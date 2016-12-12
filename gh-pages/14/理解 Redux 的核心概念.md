
## 理解 Redux 的核心概念

### Action & Action Creator

在 Redux 中，改变 State 只能通过 action，它是 store 数据的唯一来源。一般来说你会通过 store.dispatch() 将 action 传到 store。。并且，每一个 action 都必须是 Javascript 的简单对象，例如：

```
{
  type: 'ADD_TODO',
  text: 'Learn Redux'
}
```
Redux 要求 action 是可以被序列化的，使这得应用程序的状态保存、回放、Undo 之类的功能可以被实现。因此，action 中不能包含诸如函数调用这样的不可序列化字段。

action 的格式是有建议规范的，可以包含以下字段：
```
{
  type: 'ADD_TODO',
  payload: {
    text: 'Do something.'
  },
  `meta: {}`
}
```
如果 action 用来表示出错的情况，则可能为：
```
{
  type: 'ADD_TODO',
  payload: new Error(),
  error: true
}
```
type 是必须要有的属性，其他都是可选的。完整建议请参考 [Flux Standard Action(FSA)](https://github.com/acdlite/flux-standard-action) 定义。已经有不少第三方模块是基于 FSA 的约定来开发了。

**Action Creator**

事实上，创建 action 对象很少用这种每次直接声明对象的方式，更多地是通过一个创建函数。这个函数被称为Action Creator，例如：
```
function addTodo(text) {
  return {
    type: ADD_TODO,
    text
  };
}
```
Action Creator 看起来很简单，但是如果结合上 Middleware 就可以变得非常灵活，后面会专门讲 Middleware 。

### Reducer

我们先来看一下 Javascript 中 [Array.prototype.reduce](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce_clone) 的用法：

```
const initState = '';
const actions = ['a', 'b', 'c'];
// 传入当前的 state 和 action ，返回新的 state
const newState = actions.reduce((curState, action) => curState + action);
console.log( newState );

```

对应的理解，Redux 中的 reducer 是一个纯函数，传入state和action，返回一个新的state tree，简单而纯粹的完成某一件具体的事情，没有依赖，**简单而纯粹是它的标签**。

```
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

### Store

Store 就是用来维持应用所有的 [state 树]() 的一个对象。
改变 store 内 state 的惟一途径是对它 dispatch 一个 [action]()。

Store 是一个具有以下四个方法的对象：
- `getState()`
- `dispatch(action)`
- `subscribe(listener)`
- `replaceReducer(nextReducer)`

#### getState()

返回应用当前的 state 树。
它与 store 的最后一个 reducer 返回值相同。

返回值：应用当前的 state 树。

#### dispatch(action)

dispatch 分发 action。这是触发 state 变化的惟一途径。

会使用当前 `getState()` 的结果和传入的 `action` 以同步方式的调用 store 的 reduce 函数。返回值会被作为下一个 state。从现在开始，这就成为了 `getState()` 的返回值，同时变化监听器(change listener)会被触发。

> 在 Redux 里，只会在根 reducer 返回新 state 结束后再会调用事件监听器，因此，你可以在事件监听器里再做 dispatch。惟一使你不能在 reducer 中途 dispatch 的原因是要确保 reducer 没有副作用。如果 action 处理会产生副作用，正确的做法是使用异步 action 创建函数。

示例：

```
import { createStore } from 'redux'

// reducer
const todos = (state = [''], action) => {
  switch (action.type) {
    case 'ADD_TODO':
      console.log(Object.assign([], state, [action.text]))
      return Object.assign([], state, [action.text]);
    default:
      return state;
  }
}

let store = createStore(todos, [ 'Use Redux' ])

// action creator
function addTodo(text) {
  return {
    type: 'ADD_TODO',
    text
  }
}

// dispatch
store.dispatch(addTodo('Read the docs'))
store.dispatch(addTodo('Read about the middleware'))

```

#### subscribe(listener)

添加一个变化监听器。每当 dispatch action 的时候就会执行，state 树中的一部分可能已经变化。这是一个底层 API。多数情况下，你不会直接使用它，会使用一些 React（或其它库）的绑定。

示例

```
import { createStore } from 'redux'

// reducer
const todos = (state = [''], action) => {
  switch (action.type) {
    case 'ADD_TODO':
      return Object.assign([], state, [action.text]);
    default:
      return state;
  }
}

let store = createStore(todos, [ 'Use Redux' ])

// action creator
function addTodo(text) {
  return {
    type: 'ADD_TODO',
    text
  }
}

const handleChange =  () => {
  console.log(store.getState());
}

let unsubscribe = store.subscribe(handleChange)

handleChange()

// dispatch
store.dispatch(addTodo('Read the docs'))
store.dispatch(addTodo('Read about the middleware'))

```
