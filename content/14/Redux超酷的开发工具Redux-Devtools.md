<h1 style="font-size: 40px;text-align:center;color: #007cdc;">Redux超酷的开发工具Redux-Devtools</h1>

> **重要提示：** 本教程配套示例代码请前往[redux-complete-sample](https://github.com/GuoYongfeng/redux-complete-sample)下载，课程中会有大量的示例操作，操作说明均基于这个配套的示例代码仓库，所以为了方便学习，请务必下载安装并启动。


在前一部分内容[](http://guoyongfeng.github.io/idoc/html/React%E8%AF%BE%E7%A8%8B%E4%B8%93%E9%A2%98/%E8%AE%A9Redux%E6%9D%A5%E7%AE%A1%E7%90%86%E4%BD%A0%E7%9A%84%E5%BA%94%E7%94%A8%EF%BC%88%E4%B8%80%EF%BC%89.html)中，我们学习了基础部分的Redux知识，并且完成了几个示例练习。如果你已经都能够轻松掌握了，恭喜你，现在是时候来点好玩的干货了。

而且有计划地，我把上一部分可能涉及到相对不太好理解的内容都放到这里，希望我们一起来进入redux学习的深水区。

## 超酷的开发工具 Redux-devtools

redux-devtools是一个有趣而又高效的redux开发工具，如果你想直接在github上查看相关的内容，请前往[这里](https://github.com/gaearon/redux-devtools)。事实上，也鼓励大家养成在github上学习第一手资料的习惯。


ok，首先，让我们来下载redux-devtools的相关资料

```
$ npm install --save-dev redux-devtools redux-devtools-log-monitor redux-devtools-dock-monitor
```

- `redux-devtools：`redux的开发工具包，而且DevTools支持自定义的 monitor 组件，所以我们可以完全自定义一个我们想要的 monitor 组件的UI展示风格，以下两个是我们示例中用到的。
- `redux-devtools-log-monitor：` 这是Redux Devtools 默认的 monitor ，它可以展示state 和 action 的一系列信息，而且我们还可以在monitor改变它们的值。
- `redux-devtools-dock-monitor：`这monitor支持键盘的快捷键来轻松的改变tree view在浏览器中的展示位置，比如不断的按‘ctrl + q’组合键可以让展示工具停靠在浏览器的上下左右不同的位置，按“ctrl+h”组合键则可以控制展示工具在浏览器的显示或隐藏的状态。

接下来我们在containers目录新增一个DevTools.js文件，并且设置monitor。
代码清单：`demo-redux-devtools/containers/DevTools.js`
```
import React from 'react';
import { createDevTools } from 'redux-devtools';
import LogMonitor from 'redux-devtools-log-monitor';
import DockMonitor from 'redux-devtools-dock-monitor';

export default createDevTools(
  <DockMonitor toggleVisibilityKey='ctrl-h'
               changePositionKey='ctrl-q'>
    <LogMonitor />
  </DockMonitor>
);

```

然后在index.js文件引入这个容器组件
代码清单：`demo-redux-devtools/index.js`
```
import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import App from './containers/App'
import DevTools from './containers/DevTools'
import { createStore, compose } from 'redux';
import todoApp from './reducers'

// 把多个 store 增强器从右到左来组合起来，依次执行
// 这个地方完全可以不用compose，演示一下compose的使用
const enhancer = compose(
  DevTools.instrument()
);

let store = createStore(todoApp, enhancer)
let rootElement = document.getElementById('app')

render(
  <Provider store={store}>
    <div>
      <App />
      <DevTools />
    </div>
  </Provider>,
  rootElement
)

```

> **注意：**在实际项目开发中时应该根据环境来确定`<DevTools />`组件的展示与否，示例中是在开发环境的演示，直接放在`Provider`里面。

ok，重新启动示例应用即可，样子是这样的：

<img src="/img/redux/devtools.png" />
