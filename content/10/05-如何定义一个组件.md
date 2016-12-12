# React第四讲课堂笔记（定义组件）

用 `React.createClass` 或者 `React.Component` 定义组件时允许传入相应的配置及组件 `API` 的使用，包括组件生命周期提供的一系列钩子函数。

## 1. `组件初始定义`

- getDefaultProps 得到默认属性对象，这个在ES6的时候不需要这样定义
- propTypes 属性检验规则
- mixins 组件间公用方法


## 2. `初次创建组件时调用`

- getInitialState 得到初始状态对象
- render 返回组件树. 必须设置
- componentDidMount 渲染到 dom 树中是调用，只在客户端调用，可用于获取原生节点

## 3. `组件的属性值改变时调用`

- componentWillReceiveProps 属性改变调用
- shouldComponentUpdate 判断是否需要重新渲染
- render 返回组件树. 必须设置
- componentDidUpdate 渲染到 dom 树中是调用, 可用于获取原生节点

## 4. `销毁组件`
- componentWillUnmount 组件从 dom 销毁前调用

## 5. `示例`

```
import React, { Component } from 'react';

class LifeCycle extends Component {

  props = {
    value: '开始渲染'
  }

  componentWillReceiveProps(nextProps){
    console.log('componentWillReceiveProps');
    this.setState({
        value: nextProps.value
    });
  }

  shouldComponentUpdate(nextProps,nextState){
    console.log('shouldComponentUpdate');
    return true;
  }

  componentWillUpdate(nextProps,nextState){
    console.log('componentWillUpdate');
  }

  componentWillMount(){
    console.log('componentWillMount');
  }

  render() {
    console.log('render');
    return <span>{this.props.value}</span>
  }

  componentDidMount() {
      console.log('componentDidMount');
  }

  componentDidUpdate(prevProps,prevState) {
      console.log('componentDidUpdate');
  }

  componentWillUnmount(prevProps,prevState) {
      console.log('componentWillUnmount');
  }
}

export default LifeCycle;

```

调用组件并销毁组件示例
```
import React, { Component } from 'react';
import LifeCycleDemo from './LifeCycleDemo';

class DestroyComponent extends Component {

  state = {
    value:1,
    destroyed:false
  }

  increase = () => {
    this.setState({
      value: this.state.value + 1
    });
  }

  destroy = () => {
    this.setState({
      destroyed: true
    });
  }

  render() {
    if(this.state.destroyed){
        return null;
    }

    return <div>
      <p>
        <button onClick={this.increase}>每次加1</button>
        <button onClick={this.destroy}>干掉这两个按钮</button>
      </p>
      <LifeCycleDemo value={this.state.value}/>
    </div>;
  }
}

export default DestroyComponent;

```

## 6. `回顾组件的渲染过程`
```
# 创建 -> 渲染 -> 销毁

getDefaultProps()
getInitialState()
componentWillMount()
render()
componentDidMount()
componentWillUnmount()

# 更新组件

componentWillReceiveProps()
shouldComponentUpdate()
componentWillUpdate()
render()
componentDidUpdate()
```
