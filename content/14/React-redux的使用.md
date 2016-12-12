
## 使用 React-redux 连接 react 和 redux

### 没有react-redux的写法

封装一个组件，将组件和Redux做基本的组合
```
import { createStore } from 'redux';
import React, { Component } from 'react';
import ReactDOM from 'react-dom';

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

const store = createStore(counter);

// Counter 组件
class Counter extends Component {
  render(){
    return (
      <div>
        <h1>{this.props.value}</h1>
        <button onClick={this.props.onIncrement}>点击加1</button>
        <button onClick={this.props.onDecrement}>点击减1</button>
      </div>
    )
  }
}

const PureRender = () => {
  ReactDOM.render(
      <Counter
        value={store.getState()}
        onIncrement={ () => store.dispatch({type: "INCREMENT"}) }
        onDecrement={ () => store.dispatch({type: "DECREMENT"}) }
      />, document.getElementById('app')
  );
}

// store subscribe 订阅或是监听view（on）
store.subscribe(PureRender)
PureRender()

```


### React-redux 提供的 connect 和 Provider

`<Provider store>` 使组件层级中的 `connect()` 方法都能够获得 `Redux store`。正常情况下，你的根组件应该嵌套在 ``<Provider>` 中才能使用 `connect()` 方法。

```
ReactDOM.render(
  {/*  使组件层级中的 connect() 方法都能够获得 Redux store */}
  <Provider store={store}>
    {/* 这里传入的组件MyRootComponent是组件层级的根组件 */}
    <MyRootComponent />
  </Provider>,
  rootEl
);
```

`connect([mapStateToProps], [mapDispatchToProps], [mergeProps], [options])`
connect方法是用来连接 React 组件与 Redux store，连接操作不会改变原来的组件类，反而返回一个新的已与 Redux store 连接的组件类。

**使用react-redux的一个简单完整示例**

```
import React, { Component, PropTypes } from 'react'
import ReactDOM from 'react-dom'
import { createStore } from 'redux'
import { Provider, connect } from 'react-redux'

// 这是一个展示型组件 Counter
class Counter extends Component {
  render() {
    const { value, onIncreaseClick } = this.props
    return (
      <div>
        <span>{value}</span>
        <button onClick={onIncreaseClick}>戳我加1</button>
      </div>
    )
  }
}

Counter.propTypes = {
  value: PropTypes.number.isRequired,
  onIncreaseClick: PropTypes.func.isRequired
}

// Action
const increaseAction = { type: 'increase' }

// Reducer
function counter(state = { count: 0 }, action) {
  let count = state.count
  switch (action.type) {
    case 'increase':
      return { count: count + 1 }
    default:
      return state
  }
}

// Store
let store = createStore(counter)

// Map Redux state to component props
function mapStateToProps(state) {
  // 这里拿到的state就是store里面给的state
  console.log(state);
  return {
    value: state.count
  }
}

// Map Redux actions to component props
function mapDispatchToProps(dispatch) {
  // dispatch(action) { }
  return {
    onIncreaseClick: () => dispatch(increaseAction)
  }
}

class App extends Component {
  render() {
    // store里的state经过connect连接后给了根组件的props
    console.log(this.props);
    return (
      <div>
        <h1>学习使用react-redux</h1>
        <Counter {...this.props} />
      </div>
    )
  }
}

// Connected Component
let RootApp = connect(
  mapStateToProps,
  mapDispatchToProps
)(App)

ReactDOM.render(
  <Provider store={store}>
    <RootApp />
  </Provider>,
  document.getElementById('app')
)

```

实际应用中，connect这个部分会比较复杂，我们后续高级部分内容进行补充。
