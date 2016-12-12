# React第九讲课堂笔记（mixin）

mixin 是一个普通对象，通过 mixin 可以在不同组件间共享代码，使你的React程序变得更为可重用。

`注意，ES6语法不支持mixin写法，而是可以通过decorator去实现代码共享，这里使用ES5语法做示例说明。`

## 1. `ES5 语法实现 mixin`
```

import React from 'react';

var SetIntervalMixin = {
  componentWillMount: function() {
    this.intervals = [];
  },
  setInterval: function() {
    this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    this.intervals.forEach(clearInterval);
  }
};

var MixinDemo = React.createClass({
  // Use the mixin
  mixins: [SetIntervalMixin],
  getInitialState: function() {
    return {seconds: 0};
  },
  componentDidMount: function() {
    // Call a method on the mixin
    this.setInterval(this.tick, 1000);
  },
  tick: function() {
    this.setState({seconds: this.state.seconds + 1});
  },
  render: function() {
    return (
      <p>
        计时器已经运行了： {this.state.seconds} 秒.
      </p>
    );
  }
});

export default MixinDemo;

```

## 2. `用high-order component的方式实现`

```
import React, { Component } from 'react';

let Mixin = MixinComponent => class extends Component {
  constructor() {
    super();
    this.state = { val: 0 };
    this.update = this.update.bind(this);
  }
  update(){
    this.setState({val: this.state.val + 1});
  }
  componentWillMount(){
    console.log('will mount...')
  }
  render(){
    return (
      <MixinComponent
        update={this.update}
        {...this.state}
        {...this.props}
       />
    )
  }
  componentDidMount(){
    console.log('mounted...')
  }
}

const Button = (props) => {
  return (
    <button onClick={props.update}>
      {props.txt} - {props.val}
    </button>
  )
}

const Label = (props) => {
  return (
    <label onMouseMove={props.update}>
      {props.txt} - {props.val}
    </label>
  )
}

let ButtonMixed = Mixin(Button);
let LabelMixed = Mixin(Label);

class Mixins extends Component {
  render(){
    return (
      <div>
        <ButtonMixed txt="button" />
        <LabelMixed txt="label" />
      </div>
    )
  }
}

export default Mixins;
```
