
## Redux 的顶层 API 介绍

### createStore

调用方式：createStore(reducer, [initialState])

创建一个 Redux store 来以存放应用中所有的 state，应用中应有且仅有一个 store。
这个API返回一个store，这个store中保存了应用所有 state 的对象。改变 state 的惟一方法是 dispatch action。你也可以 subscribe 监听 state 的变化，然后更新 UI。我们来看一个示例

**我们可以试着模拟 createStore，深入了解其原理**

```javascript
// reducer 纯函数，具体的action执行逻辑
const counter = (state = 0, action) => {
  switch (action.type) {
      case 'INCREMENT':
        return state + 1;
      case 'DECREMENT':
        return state - 1;
      default:
        return state;
  }
}

// 模拟create store，了解其原理
const createStore = (reducer) => {
  let state;
  let listeners = [];

  const getState = () => state;

  const dispatch = (action) => {
    state = reducer(state, action);
    listeners.forEach(listener => listener());
  }

  const subscribe = (listener) => {
      listeners.push(listener);
      return () => {
        listeners = listeners.filter(item => item !== listener);
      }
  }

  dispatch({});

  return { getState, dispatch, subscribe };
}

const store = createStore(counter);

// view 对应到React里面的component
const PureRender = () => {
  document.body.innerText = store.getState();
}

// store subscribe 订阅或是监听view（on）
store.subscribe(PureRender);
PureRender();

document.addEventListener('click', function( e ){
  // store dispatch 调度分发一个 action（fire）
  store.dispatch({ type: 'DECREMENT'});
})

```

### combineReducers

调用方式：combineReducers(reducers)

随着应用变得复杂，需要对 reducer 函数进行拆分，拆分后的每一块独立负责管理 state 的一部分。把一个由多个不同 reducer 函数作为 value 的 object，合并成一个最终的 reducer 函数，然后就可以对这个 reducer 调用 createStore。

**示例如下**

代码清单：`reducer/todos.js`

```javascript
export default function todos(state = [], action) {
  switch (action.type) {
  case 'ADD_TODO':
    return state.concat([action.text])
  default:
    return state
  }
}
```

代码清单：`reducer/counter.js`

```javascript
export default function counter(state = 0, action) {
  switch (action.type) {
  case 'INCREMENT':
    return state + 1
  case 'DECREMENT':
    return state - 1
  default:
    return state
  }
}
```

代码清单：`reducers/index.js`

```javascript
import { combineReducers } from 'redux'
import todos from './todos'
import counter from './counter'

export default combineReducers({
  todos,
  counter
})
```

代码清单：`App.js`
```javascript
import { createStore } from 'redux'
import reducer from './reducer/index.js'

let store = createStore(reducer)
console.log('当前的 state :', store.getState())

store.dispatch({
  type: 'ADD_TODO',
  text: 'Use Redux'
})
store.dispatch({
  type: 'INCREMENT',
})
console.log('改变后的 state :', store.getState())


```

### applyMiddleware

调用方式：applyMiddleware(...middlewares)

使用包含自定义功能的 middleware 来扩展 Redux 是一种推荐的方式。Middleware 可以让你包装 store 的 dispatch 方法来达到你想要的目的。同时， middleware 还拥有“可组合”这一关键特性。多个 middleware 可以被组合到一起使用，形成 middleware 链。其中，每个 middleware 都不需要关心链中它前后的 middleware 的任何信息。

具体用法我们高级部分详细说明。

### bindActionCreators

调用方式：bindActionCreators(actionCreators, dispatch)

惟一使用 bindActionCreators 的场景是当你需要把 action creator 往下传到一个组件上，却不想让这个组件觉察到 Redux 的存在，而且不希望把 Redux store 或 dispatch 传给它。

具体用法我们高级部分详细说明。

### compose

调用方式：compose(...functions)

compose 用来实现从右到左来组合传入的多个函数，它做的只是让你不使用深度右括号的情况下来写深度嵌套的函数，仅此而已。
