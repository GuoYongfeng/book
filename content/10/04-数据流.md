# React第三讲课堂笔记（数据流）

## 1. `state setState`

可以把组件当成一个状态机，我们给组件传入数据作为输入，组件在内部进行逻辑处理，之后返回一段HTML结构作为输出。

而传入的数据即为props，组件内部的状态控制即为state，每一次状态对应于组件的一个 ui 。

```
import React, { Component } from 'react';

class StateDemo extends Component {

  state = {
    secondsElapsed: 0
  }

  tick(){
    this.setState({ secondsElapsed: this.state.secondsElapsed + 1 });
  }

  componentDidMount(){
    this.interval = setInterval( this.tick.bind(this), 1000 );
  }

  componentWillUnmount(){
    clearInterval(this.interval);
  }

  render(){
    return (
      <div>目前已经计时：{this.state.secondsElapsed}秒</div>
    )
  }
}

export default StateDemo;

```


## 2. `props`
通过 this.props 可以获取传递给该组件的属性值，还可以通过定义 getDefaultProps 来指定默认属性值（这是ES5的写法，ES6定义组件的默认props可以直接写props）

下面几个是props的常用API：
- `this.props.children`
- `this.props.map`
- `this.props.filter`

**props是调用组件的时候传递进去的数据，一般用于组件树数据传递**

```
import React, { Component } from 'react';

class PropsDemo extends Component {
  props = {
    title: '这是默认的title属性值'
  }
  render(){
    console.log(this.props);

    return <b>{this.props.title}</b>
  }
}

export default PropsDemo;


// 组件调用方式
// <PropsDemo title="设置的标题" />
```

## 3. `propTypes`

通过指定 propTypes 可以校验props属性值的类型，校验可提升开发者体验，用于约定统一的接口规范。

```
import React, { Component, PropTypes } from 'react';

class PropTypesDemo extends Component {

  render(){
    return <b>{this.props.title}</b>
  }
}

PropTypesDemo.defaultProps= {
  title: '我是默认的title'
}

PropTypesDemo.propTypes = {
  title: PropTypes.string.isRequired
}

export default PropTypesDemo;

```
