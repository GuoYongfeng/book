## 使用middleware实现异步 action 和异步数据流

redux的生态在持续的完善，其中就有不少优秀的 middleware 供开发者使用，同时大家也可以实现自己的middleware。

现在让我们来使用以下两个中间件来完成一个示例：
- [redux-thunk]() — Redux-Thunk可以让你的action creator返回一个function而不是action。这可以用于延迟dispath一个action或是在特定条件下dispatch才触发。他的内部函数接受store的dispath和getState方法作为参数。
- [redux-logger]() — redux-logger的用处很明显，就是用于记录所有 action 和下一次 state 的日志。

下面我们到示例项目的demo-middleware-apply下开始代码操作：

在此之前我们需要下载几个示例项目中依赖到的package
```
$ npm install --save-dev isomorphic-fetch redux-thunk redux-logger
```
- `isomorphic-fetch`：用于ajax请求数据


### 入口
`index.js`
```
import 'babel-polyfill'

import React from 'react'
import { render } from 'react-dom'
import Root from './containers/Root'

render(
  <Root />,
  document.getElementById('app')
)

```

### 容器型组件

`containers/Root.js`
```
import React, { Component } from 'react'
import { Provider } from 'react-redux'
import configureStore from '../store/configureStore'
import App from './App'

const store = configureStore()

export default class Root extends Component {
  render() {
    return (
      <Provider store={store}>
        <App />
      </Provider>
    )
  }
}

```

`containers/App.js`

```
import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux'
import { selectSubreddit, fetchPostsIfNeeded, invalidateSubreddit } from '../actions'
import Picker from '../components/Picker'
import Posts from '../components/Posts'

const style = { opacity: isFetching ? 0.5 : 1 }

class App extends Component {
  constructor(props) {
    super(props)
    this.handleChange = this.handleChange.bind(this)
    this.handleRefreshClick = this.handleRefreshClick.bind(this)
  }

  componentDidMount() {
    const { dispatch, selectedSubreddit } = this.props
    dispatch(fetchPostsIfNeeded(selectedSubreddit))
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.selectedSubreddit !== this.props.selectedSubreddit) {
      const { dispatch, selectedSubreddit } = nextProps
      dispatch(fetchPostsIfNeeded(selectedSubreddit))
    }
  }

  handleChange(nextSubreddit) {
    this.props.dispatch(selectSubreddit(nextSubreddit))
  }

  handleRefreshClick(e) {
    e.preventDefault()

    const { dispatch, selectedSubreddit } = this.props
    dispatch(invalidateSubreddit(selectedSubreddit))
    dispatch(fetchPostsIfNeeded(selectedSubreddit))
  }

  render() {

    const { selectedSubreddit, posts, isFetching, lastUpdated } = this.props

    return (
      <div>
        <Picker value={selectedSubreddit}
                onChange={this.handleChange}
                options={[ 'guoyongfeng', 'tj' ]} />
        <p>
          {lastUpdated &&
            <span>
              Last updated at {new Date(lastUpdated).toLocaleTimeString()}.
              {' '}
            </span>
          }
          {!isFetching &&
            <a href='#'
               onClick={this.handleRefreshClick}>
              Refresh
            </a>
          }
        </p>
        {isFetching && posts.length === 0 &&
          <h2>请稍等...</h2>
        }
        {!isFetching && posts.length === 0 &&
          <h2>暂无数据.</h2>
        }
        <div style={ style }>
          <Posts posts={posts} />
        </div>

      </div>
    )
  }
}

App.propTypes = {
  selectedSubreddit: PropTypes.string.isRequired,
  posts: PropTypes.object.isRequired,
  isFetching: PropTypes.bool.isRequired,
  lastUpdated: PropTypes.number,
  dispatch: PropTypes.func.isRequired
}

function mapStateToProps(state) {
  const { selectedSubreddit, postsBySubreddit } = state
  const {
    isFetching,
    lastUpdated,
    items: posts
  } = postsBySubreddit[selectedSubreddit] || {
    isFetching: true,
    items: {}
  }

  return {
    selectedSubreddit,
    posts,
    isFetching,
    lastUpdated
  }
}

export default connect(mapStateToProps)(App)

```


### 展示型组件

`components/Picker.js`
```
import React, { Component, PropTypes } from 'react'

export default class Picker extends Component {
  render() {
    const { value, onChange, options } = this.props

    return (
      <span>
        <h1>{value}</h1>
        <select onChange={e => onChange(e.target.value)}
                value={value}>
          {options.map(option =>
            <option value={option} key={option}>
              {option}
            </option>)
          }
        </select>
      </span>
    )
  }
}

Picker.propTypes = {
  options: PropTypes.arrayOf(
    PropTypes.string.isRequired
  ).isRequired,
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired
}

```

`components/Posts.js`
```
import React, { PropTypes, Component } from 'react'

export default class Posts extends Component {
  render() {
    let bio = this.props.posts;

    return (
      <div>
        <h3> 用户信息 </h3>
          {bio.avatar_url && <li className="list-group-item"> <img src={bio.avatar_url} className="img-rounded img-responsive"/></li>}
          {bio.name && <li className="list-group-item">Name: {bio.name}</li>}
          {bio.login && <li className="list-group-item">Username: {bio.login}</li>}
          {bio.email && <li className="list-group-item">Email: {bio.email}</li>}
          {bio.location && <li className="list-group-item">Location: {bio.location}</li>}
          {bio.company && <li className="list-group-item">Company: {bio.company}</li>}
          {bio.followers && <li className="list-group-item">Followers: {bio.followers}</li>}
          {bio.following && <li className="list-group-item">Following: {bio.following}</li>}
          {bio.public_repos && <li className="list-group-item">Public Repos: {bio.public_repos}</li>}
          {bio.blog && <li className="list-group-item">Blog: <a href={bio.blog}> {bio.blog}</a></li>}
      </div>
    )
  }
}

Posts.propTypes = {
  posts: PropTypes.object.isRequired
}

```


### Action & Action Creator


`actions/index.js`
```
import fetch from 'isomorphic-fetch'

export const REQUEST_POSTS = 'REQUEST_POSTS'
export const RECEIVE_POSTS = 'RECEIVE_POSTS'
export const SELECT_SUBREDDIT = 'SELECT_SUBREDDIT'
export const INVALIDATE_SUBREDDIT = 'INVALIDATE_SUBREDDIT'

export function selectSubreddit(subreddit) {
  return {
    type: SELECT_SUBREDDIT,
    subreddit
  }
}

export function invalidateSubreddit(subreddit) {
  return {
    type: INVALIDATE_SUBREDDIT,
    subreddit
  }
}

function requestPosts(subreddit) {
  return {
    type: REQUEST_POSTS,
    subreddit
  }
}

function receivePosts(subreddit, json) {

  return {
    type: RECEIVE_POSTS,
    subreddit,
    posts: json,
    receivedAt: Date.now()
  }
}

function fetchPosts(subreddit) {

  return dispatch => {
    return fetch(`https://api.github.com/users/${subreddit}`)
      .then(response => response.json())
      .then(json => {

        dispatch(receivePosts(subreddit, json))
      })
  }
}

function shouldFetchPosts(state, subreddit) {
  const posts = state.postsBySubreddit[subreddit]
  if (!posts) {
    return true
  } else if (posts.isFetching) {
    return false
  } else {
    return posts.didInvalidate
  }
}

export function fetchPostsIfNeeded(subreddit) {
  return (dispatch, getState) => {
    if (shouldFetchPosts(getState(), subreddit)) {
      return dispatch(fetchPosts(subreddit))
    }
  }
}

```

### reducers

`reducers/index.js`
```
import { combineReducers } from 'redux'
import {
  SELECT_SUBREDDIT, INVALIDATE_SUBREDDIT,
  REQUEST_POSTS, RECEIVE_POSTS
} from '../actions'

function selectedSubreddit(state = 'guoyongfeng', action) {
  switch (action.type) {
  case SELECT_SUBREDDIT:
    return action.subreddit
  default:
    return state
  }
}

function posts(state = {
  isFetching: false,
  didInvalidate: false,
  items: {}
}, action) {
  switch (action.type) {
    case INVALIDATE_SUBREDDIT:
      return Object.assign({}, state, {
        didInvalidate: true
      })
    case REQUEST_POSTS:
      return Object.assign({}, state, {
        isFetching: true,
        didInvalidate: false
      })
    case RECEIVE_POSTS:
      return Object.assign({}, state, {
        isFetching: false,
        didInvalidate: false,
        items: action.posts,
        lastUpdated: action.receivedAt
      })
    default:
      return state
  }
}

function postsBySubreddit(state = { }, action) {
  switch (action.type) {
    case INVALIDATE_SUBREDDIT:
    case RECEIVE_POSTS:
    case REQUEST_POSTS:
      return Object.assign({}, state, {
        [action.subreddit]: posts(state[action.subreddit], action)
      })
    default:
      return state
  }
}

const rootReducer = combineReducers({
  postsBySubreddit,
  selectedSubreddit
})

export default rootReducer

```

### store

`store/configureStore.js`
```
import { createStore, applyMiddleware } from 'redux'
import thunkMiddleware from 'redux-thunk'
import createLogger from 'redux-logger'
import rootReducer from '../reducers'

const loggerMiddleware = createLogger()

export default function configureStore(initialState) {
  return createStore(
    rootReducer,
    initialState,
    applyMiddleware(
      thunkMiddleware,
      loggerMiddleware
    )
  )
}

```

最后，启动服务
```
$ cd demo-middleware-apply
$ webpack-dev-server --progress --colors
```

示例展示的效果是这样的

<img src="/img/redux/middleware.png" />

## 更多内容推荐

如果你还是对函数式编程不太习惯，我鼓励你看一下来自[Brian Lonsdorf](https://twitter.com/drboolean)的优秀文献：

- [Hey Underscore, You are Doing it Wrong! ](http://www.youtube.com/watch?v=m3svKOdZijA)：它介绍了很多函数式编程知识和少量的Underscore内容；
- [Professor Frisby’s Mostly Adequate Guide to Functional Programming](http://drboolean.gitbooks.io/mostly-adequate-guide/content/index.html)
