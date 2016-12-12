
# React第七讲课堂笔记（组件嵌套）

组件间的嵌套是在开发过程中最为常用的，其中会有以下几种组件嵌套的方式。

## 1. `受限组件 && 非受限组件`

受限组件示例：
```
render() {
  return <input type="text" value="Hello!" />;
}
```
非受限组件示例：
```
render() {
  return <input type="text" />;
}
```
## 2. `使用自定义的组件`

```
'use strict';

import React, { Component } from 'react';

class ComponentA extends Component {
  render() {
    return <a href='#'>我是组件A<br/></a>
  }
}

class ComponentB extends Component {
  render() {
    return <a href='#'>我是组件B</a>
  }
}


class SelfCreateComponent extends Component {
  render() {
    return (
      <i>
        <ComponentA />
        <ComponentB />
      </i>
    );
  }
}

export default SelfCreateComponent;

```
## 3. `使用 CHILDREN 组合`

自定义组件中可以通过 this.props.children 访问自定义组件的子节点
```
'use strict';

import React, { Component } from 'react';

// 定义一个组件，通过React.Children 拿到组件里面的子元素
class ListComponent extends Component {
  render(){
    return <ul>
      {
        React.Children.map( this.props.children, function(c){
          return <li>{c}</li>;
        })
      }
    </ul>
  }
}

class UseChildrenComponent extends Component {
  render(){
    return (
      <ListComponent>
        <a href="#">Facebook</a>
        <a href="#">Google</a>
        <a href="#">SpaceX</a>
      </ListComponent>
    )
  }
}

export default UseChildrenComponent;

```
