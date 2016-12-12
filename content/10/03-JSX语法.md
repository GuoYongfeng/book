# React第二讲课堂笔记（JSX 语法）

## 1. `什么是 JSX`

类似 xml 的语法，用来描述组件树
```
var HelloMessage = React.createClass({
  render: function() {
    return <div>Hello {this.props.name}</div>;
  }
});

React.render(<HelloMessage name="John" />, mountNode);
```

JSX是可选的，并不强制要求使用。如果不用JSX，用React提供的API写的话，应该是这样的，直接调用React的API来定义组件和DOM元素。

```

var HelloMessage = React.createClass({
  displayName: "HelloMessage",
  render: function() {
    return React.createElement("div", null, "Hello ", this.props.name);
  }
});

React.render(React.createElement(HelloMessage, {name: "John"}), mountNode);
```

## 2. `为什么要使用 JSX`

你不需要为了 React 使用 JSX，可以直接使用纯粹的 JS。但我们更建议使用 JSX , **因为它能定义简洁且我们熟知的包含属性的树状结构语法。**

## 3. `注释`
```
import React, { Component } from 'react';

const name = 'yongfeng';
const MyComponent = () => {
	<Nav>
    {/* 一般注释, 用 {} 包围 */}
    <a
      /* 多
         行
         注释 */
      className={ name ? 'a' : 'b' } // 行尾注释
      href="http://guoyongfeng.github.io/idoc"
    > 注释 </a>
  </Nav>
};

export default MyComponent;
```

## 4. `命名`

```
import React, { Component } from 'react';

// 1. 组件命名遵循驼峰命名，首字母大写
class ComponentDemo extends Component {
  render(){
    return <div> 你好，兄弟... </div>
  }
}

export default ComponentDemo;
```

## 5. `根元素个数`

```
import React, { Component } from 'react';

class ComponentDemo extends Component {
  render(){
	// 以下写法直接报错
    return (
      <div>
        hello
      </div>
      <h1> hello h1 </h1>
    );
  }
}

export default ComponentDemo;
```

React只有一个限制， 组件只能渲染单个根节点。如果你想要返回多个节点，它们必须被包含在同一个节点里。

## 6. `嵌入变量`

`{}花括号内可以写JS逻辑，表达式和方法定义都可以`

```
let person = <Person name={window.isLoggedIn ? window.name : ''} />;
```

## 7. `styles`
```
import React, { Component } from 'react';

class StyleDemo extends Component {
  render(){
    // 5. 在JS文件里面给组件定义样式
    var MyComponentStyles = {
        color: 'blue',
        fontSize: '28px'
    };

    return (
      <div style={MyComponentStyles}>
          可以直接这样写行内样式
      </div>
    )
  }
}

export default StyleDemo;
```
## 8. `JSX SPREAD`

可以通过 `{...obj}` 来批量设置一个对象的键值对到组件的属性

```
import React, { Component } from 'react';

class SpreadDemo extends Component {
  componentWillMount(){
    console.log(this.props);
  }
  render(){
    return <h1> {this.props.name} is a {this.props.type} </h1>;
  }
}

export default SpreadDemo;

```
## 9. `属性名不能和 js 关键字冲突`

例如：`className readOnly htmlfor`
