## 快速上手

本次教程内容的所有示例可以在[](https://github.com/GuoYongfeng/redux-complete-sample)

``` shell
$ git clone git@github.com:GuoYongfeng/redux-complete-sample.git
$ cd redux-complete-sample && npm install
$ cd demo-redux-start
$ webpack-dev-server --progress --colors
```

示例代码快速体验

``` javascript
import { createStore } from 'redux';

// 这是一个 reducer，形式为 (state, action) => state 的纯函数。描述了 action 如何把 state 转变成下一个 state。

// state 的形式取决于你，可以是基本类型、数组、对象、
// 甚至是 Immutable.js 生成的数据结构。惟一的要点是
// 当 state 变化时需要返回全新的对象，而不是修改传入的参数。
function counter(state = 0, action) {
  switch (action.type) {
  case 'INCREMENT':
    return state + 1;
  case 'DECREMENT':
    return state - 1;
  default:
    return state;
  }
}

// 创建 Redux store 来存放应用的状态。
// API 是 { subscribe, dispatch, getState }。
let store = createStore(counter);

// 一个单纯渲染页面内容的函数
const PureRender = () => {
  document.body.innerText = store.getState();
}

// 可以手动订阅更新，也可以事件绑定到视图层。
store.subscribe(PureRender);
// 执行渲染函数
PureRender();

// 改变内部 state 惟一方法是 dispatch 一个 action。
// action 可以被序列化，用日记记录和储存下来，后期还可以以回放的方式执行
document.addEventListener('click', function( e ){
  // store dispatch 调度分发一个 action（fire）
  store.dispatch({ type: 'DECREMENT'});
})

```
