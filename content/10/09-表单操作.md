# React第八讲课堂笔记（表单操作）

## 1. `React表单组件和 html 的不同点`

- `value/checked` 属性设置后，用户输入无效
- `textarea` 的值要设置在 `value` 属性

```
<textarea name="description" value="This is a description." />
```

- `select` 的 `value` 属性可以是数组，不建议使用 `option` 的 `selected` 属性

```
<select multiple={true} value={['B', 'C']}>
   <option value="A">Apple</option>
   <option value="B">Banana</option>
   <option value="C">Cranberry</option>
 </select>
```


- `input/textarea` 的 `onChange` 用户每次输入都会触发（即使不失去焦点）
- `radio/checkbox/option` 点击后触发 `onChange`

## 2. `综合表达组件示例`

1. 定义复选框组件Checkboxes
```
import React, { Component } from 'react';

class Checkboxes extends Component {
  render(){
      return <span>
          A
          <input onChange={this.props.handleCheck}  name="goodCheckbox" type="checkbox" value="A"/>
          B
          <input onChange={this.props.handleCheck} name="goodCheckbox" type="checkbox" value="B" />
          C
          <input onChange={this.props.handleCheck} name="goodCheckbox" type="checkbox" value="C" />
      </span>
  }
}

export default Checkboxes;

```


2. 定义单选框按钮组RadioButtons
```

import React, { Component } from 'react';

class RadioButtons extends Component {
  saySomething(){
      alert("我是一个很棒的单选框按钮组");
  }
  render(){
      return <span>
          A
          <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="A"/>
          B
          <input onChange={this.props.handleRadio} name="goodRadio" type="radio" defaultChecked value="B"/>
          C
          <input onChange={this.props.handleRadio} name="goodRadio" type="radio" value="C"/>
      </span>
  }
}

export default RadioButtons;

```

3. FormApp组件集成两个组件并处理表单逻辑
```
'use strict';

import React, { Component } from 'react';
import Checkboxes from './Checkboxes';
import RadioButtons from './RadioButtons';

class FormApp extends Component {

  state = {
      inputValue: '请输入...',
      selectValue: 'A',
      radioValue:'B',
      checkValues:[],
      textareaValue:'请输入...'
  }

  handleSubmit = (e) => {
      e.preventDefault();

      let formData = {
          input: this.refs.goodInput.value,
          select: this.refs.goodSelect.value,
          textarea: this.refs.goodTextarea.value,
          radio: this.state.radioValue,
          check: this.state.checkValues,
      }

      alert('您即将提交表单')
      console.log('你提交的数据是:')
      console.log(formData);

  }

  handleRadio = (e) => {
      this.setState({
          radioValue: e.target.value,
      })
  }

  handleCheck = (e) => {
      let checkValues = this.state.checkValues.slice();
      let newVal = e.target.value;
      let index = checkValues.indexOf(newVal);

      if( index == -1 ){
          checkValues.push( newVal )
      }else{
          checkValues.splice(index,1);
      }

      this.setState({
          checkValues: checkValues,
      })
  }

  render(){
      return <form onSubmit={this.handleSubmit}>
          <h3> 请输入内容 </h3>
          <input ref="goodInput" type="text" defaultValue={this.state.inputValue }/>
          <br/>

          <h3> 请选择 </h3>
          <select defaultValue={ this.state.selectValue } ref="goodSelect">
              <option value="A">A</option>
              <option value="B">B</option>
              <option value="C">C</option>
              <option value="D">D</option>
              <option value="E">E</option>
          </select>
          <br/>

          <h3> 单项选择 </h3>
          <RadioButtons ref="goodRadio" handleRadio={this.handleRadio} />
          <br/>

          <h3> 多选按钮 </h3>
          <Checkboxes handleCheck={this.handleCheck} />
          <br/>

          <h3> 反馈建议 </h3>
          <textarea defaultValue={this.state.textareaValue} ref="goodTextarea"></textarea>
          <br/>

          <button type="submit">确认提交</button>
      </form>
  }
}

export default FormApp;

```
