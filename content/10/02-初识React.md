# React第一讲课堂笔记（初识React）

> React 是一个用于构建用户界面的JAVASCRIPT库

## 1. `初识React`

- 只关注UI

`许多人使用React作为MVC架构的V层。 尽管React并没有假设过你的其余技术栈， 但它仍可以作为一个小特征轻易地在已有项目中使用`

- 虚拟DOM特性

`React为了更高超的性能而使用虚拟DOM作为其不同的实现。 它同时也可以由服务端Node.js渲染 － 而不需要过重的浏览器DOM支持`

- 单向数据流

`React实现了单向响应的数据流，从而减少了重复代码，这也是它为什么比传统数据绑定更简单。`

## 2. `一个简单的React组件及其渲染`

React组件通过一个 render() 方法，接受输入的参数并返回展示的对象。 以下这个例子使用了JSX，它类似于XML的语法。输入的参数通过 render() 传入组件后，将存储在this.props

`ES5 写法`
```
var React = require('react');
var ReactDOM = require('react-dom');

// 定义组件
var HelloMessage = React.createClass({
  render: function() {
    return <div> React，我们来了... </div>;
  }
});

// 组件渲染
ReactDOM.render(<HelloMessage />, rootElement);
```

`ES6 写法`
```
import React, { Component } from 'react';
import { render } from 'react-dom';

// 定义组件
class SimpleComponent extends Component {
  render(){
    return <div> React，我们来了... </div>;
  }
}

// 组件渲染
render(<HelloMessage />, rootElement);
```

## 3. `了解顶层API`

### `react.js`
```
React.Children: Object
React.Component: ReactComponent(props, context, updater)
React.DOM: Object
React.PropTypes: Object
React.cloneElement: (element, props, children)
React.createClass: (spec)
React.createElement: (type, props, children)
React.createFactory: (type)
React.createMixin: (mixin)
React.isValidElement: (object)
```


`Component API`
```
this.context: Object
this.props: Object
this.refs: Object
this.state: Object
this.setState: Object
```
### `react-dom.js`

```
ReactDOM.findDOMNode: findDOMNode(componentOrElement)
ReactDOM.render: ()
ReactDOM.unmountComponentAtNode: (container)
```

### `react-dom-server.js`

```
ReactDOMServer.renderToString
ReactDOMServer.renderToStaticMarkup
```
