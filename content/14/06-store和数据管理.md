

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
