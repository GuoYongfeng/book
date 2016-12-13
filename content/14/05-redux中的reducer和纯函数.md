

### Reducer

我们先来看一下 Javascript 中 [Array.prototype.reduce](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce_clone) 的用法：

```javascript
const initState = '';
const actions = ['a', 'b', 'c'];
// 传入当前的 state 和 action ，返回新的 state
const newState = actions.reduce((curState, action) => curState + action);
console.log( newState );

```

对应的理解，Redux 中的 reducer 是一个纯函数，传入state和action，返回一个新的state tree，简单而纯粹的完成某一件具体的事情，没有依赖，**简单而纯粹是它的标签**。

```javascript
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
```
