
## 创建展示用户信息的Profile组件

前面的头部搜索框看起来像点样子，我们接着按照原型图来进行组件拆分。拆分之前，简单完善一下Home组件，这个组件是我们进入页面看到的默认的主页部分，简单写几个字示意一下即可。代码清单：`app/containers/Home/Home.jsx`

```
import React from 'react';

export default function Home () {
  return (
    <h2 className="text-center">
      通过 Github 用户名搜索代码资料
    </h2>
  )
}
```

理一下思路，按照原型图，我们需要创建一个容器组件，该组件可由展示用户基本信息、用户仓库信息、用户评论信息的三个组件组成，暂且将这个容器组件命名为Profile，Profile内的三个展示组件分别命名为UserProfile、UserRepos、Notes。

接下来进行创建

```
$ cd app/containers && mkdir Profile
$ cd Profile && touch Profile.jsx
```

完善Profile组件基本代码
```
import React, { Component } from 'react'

class Profile extends Component {
  render(){
    return (
      <div className="row">
        <div className="col-md-4">
          UserProfile 路由的参数是：{this.props.params.username}
        </div>
        <div className="col-md-4">
          UserRepos
        </div>
        <div className="col-md-4">
          Notes
        </div>
      </div>
    )
  }
}

export default Profile

```
更新组件列表文件，代码清单：`app/containers/index.js`

```
'use strict';

export App from './App/App.jsx';
export Home from './Home/Home.jsx';
export Profile from './Profile/Profile.jsx';

```

添加一条路由，代码清单：`app/routes/index.jsx`
```
import React from 'react';
import { Route, IndexRoute } from 'react-router';
import { App, Home, Profile } from '../containers';

export default (
  <Route path="/" component={App}>
    {/* 新加了profile路由 :后面是参数params */}
    <Route path="profile/:username" component={Profile} />
    <IndexRoute component={Home} />
  </Route>
)

```

这个时候再去输入路由参数的时候，我们可以在Profile组件中通过this.props.params.username拿到了。
