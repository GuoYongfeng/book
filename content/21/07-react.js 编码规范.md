# React/JSX 编码规范

## 基本规范

- 每个文件只包含的一个 React 组件（联系紧密的组件可以使用「命名空间的形式」）。
- 始终使用 JSX 语法，不要使用 `React.createElement` 创建 ReactElement，以提高编写速度、可读性、可维护性（没有 JSX 转换的特殊场景例外，如在 `console` 中测试组件）。
- 使用 **ES6**。

## 命名规范

- **扩展名**：使用 `.js` 作为 React 组件的扩展名；
- **文件名**：使用**大驼峰命名法**，如 `MyComponent.js`；
- **组件命名**：组件名称和文件名一致，如 `MyComponent.js` 里的组件名应该是 `MyComponent`；一个目录的根组件使用 `index.js` 命名，以目录名称作为组件名称；

	```js
	// Use the filename as the component name

	// file contents
	const CheckBox = React.createClass({
	  // ...
	})

	module.exports = CheckBox;

	// in some other file
	// bad
	const CheckBox = require('./checkBox');

	// bad
	const CheckBox = require('./check_box');

	// good
	const CheckBox = require('./CheckBox');
	```

  ```js
  // for root components of a directory,
  // use index.js as the filename and use the directory name as the component name

  // bad
  const Footer = require('./Footer/Footer.js')

  // bad
  const Footer = require('./Footer/index.js')

  // good
  const Footer = require('./Footer')
  ```
- **引用命名**：React 组件使用**大驼峰命名法**，HTML 标签、组件实例使用**小驼峰命名法**；

	```js
   // bad
	const reservationCard = require('./ReservationCard');

	// good
	const ReservationCard = require('./ReservationCard');

	// bad
	const ReservationItem = <ReservationCard />;

	// good
	const reservationItem = <ReservationCard />;

	// HTML tag
	const myDivElement = <div className="foo" />;
	React.render(myDivElement, mountNode);
	```

### 带命名空间的组件

- 如果一个组件有许多关联子组件，可以以该组件作为命名空间编写、调用子组件。

	```js
	var MyFormComponent = React.createClass({ ... });

	MyFormComponent.Row = React.createClass({ ... });
	MyFormComponent.Label = React.createClass({ ... });
	MyFormComponent.Input = React.createClass({ ... });


	var Form = MyFormComponent;

	var App = (
	  <Form>
	    <Form.Row>
	      <Form.Label />
	      <Form.Input />
	    </Form.Row>
	  </Form>
	);
	```

## 组件声明

- 不要使用 `displayName` 来命名组件，通过引用来命名。

	```js
	// bad
	export default React.createClass({
	  displayName: 'ReservationCard',
	  // stuff goes here
	});

	// good
	const ReservationCard = React.createClass({
	  // stuff goes here
	});

	export default ReservationCard;
	```

## 属性


### 属性命名

- React 组件的属性使用**小驼峰命名法**；
- 使用 `className` 代替 `class` 属性；
- 使用 `htmlFor` 代替 `for` 属性。

**传递给 HTML 的属性：**

- 传递给 HTML 元素的自定义属性，需要添加 `data-` 前缀，React 不会渲染非标准属性；
- [无障碍](http://www.w3.org/WAI/intro/aria)属性 `aria-` 可以正常使用。

### 属性设置

- 在组件行内设置属性（以便 `propTypes` 校验），不要在外部改变属性的值；
- 属性较多使用 `{...this.props}` 语法；
- 重复设置属性值时，前面的值会被后面的覆盖。

```js
var component = <Component />;
component.props.foo = x; // bad
component.props.bar = y; // also bad

// good
var component = <Component foo={x} bar={y} />;

// good
var props = {};
props.foo = x;
props.bar = y;
var component = <Component {...props} />;

var props = { foo: 'default' };
var component = <Component {...props} foo={'override'} />;
console.log(component.props.foo); // 'override'
```

### 属性对齐方式

- 属性较少时可以行内排列；
- 属性较多时每行一个属性，闭合标签单独成行

```js
// bad - too long
<input type="text" value={this.state.newDinosaurName} onChange={this.inputHandler.bind(this, 'newDinosaurName')} />

// bad - aligning attributes after the tag
<input type="text"
       value={this.state.newDinosaurName}
       onChange={this.inputHandler.bind(this, 'newDinosaurName')} />

// good
<input
  type="text"
  value={this.state.newDinosaurName}
  onChange={this.inputHandler.bind(this, 'newDinosaurName')}
 />

 // if props fit in one line then keep it on the same line
<Foo bar="bar" />

// children get indented normally
<Foo
  superLongParam="bar"
  anotherSuperLongParam="baz"
>
  <Spazz />
</Foo>


// bad
<Foo
  bar="bar"
  baz="baz" />

// good
<Foo
  bar="bar"
  baz="baz"
/>
```

### 行内迭代

- 运算逻辑简单的直接使用行内迭代。

```js
return (
  <div>
    {this.props.data.map(function(data, i) {
      return (<Component data={data} key={i} />)
    })}
    </div>
);
```

## 其他代码格式

### 注释

- 组件之间的注释需要用 `{}` 包裹。

	```js
	var content = (
	  <Nav>
	    {/* child comment, put {} around */}
	    <Person
	      /* multi
	         line
	         comment */
	      name={window.isLoggedIn ? window.name : ''} // end of line comment
	    />
	  </Nav>
	);
```


### 引号使用

- HTML/JSX 属性使用**双引号** `"`；
- JS 使用**单引号** `'`；

```js
// bad
<Foo bar='bar' />

// good
<Foo bar="bar" />

// JavaScript Expression
const person = <Person name={window.isLoggedIn ? window.name : ''} />;

// HTML/JSX
const myDivElement = <div className="foo" />;
const app = <Nav color="blue" />;
const content = (
  <Container>
    {window.isLoggedIn ? <Nav /> : <Login />}
  </Container>
);
```

### 条件 HTML

- 简短的输出在行内直接三元运算符；

	```js
	{this.state.show && 'This is Shown'}
	{this.state.on ? 'On' : 'Off'}
	```
- 较复杂的结构可以在 `.render()` 方法内定义一个以 `Html` 结尾的变量。

	```js
	var dinosaurHtml = '';

	if (this.state.showDinosaurs) {
	  dinosaurHtml = (
	    <section>
	      <DinosaurTable />
	      <DinosaurPager />
	    </section>
	  );
	}

	return (
	  <div>
	    ...
	    {dinosaurHtml}
	    ...
	  </div>
	);
	```

### `()` 使用

- 多行的 JSX 使用 `()` 包裹，有组件嵌套时使用多行模式；

	```js
	// bad
	return (<div><ComponentOne /><ComponentTwo /></div>);

	// good
	var multilineJsx = (
	  <header>
	    <Logo />
	    <Nav />
	  </header>
	);

	// good
	return (
      <div>
        <ComponentOne />
        <ComponentTwo />
      </div>
    );
	```
- 单行 JSX 省略 `()`。

	```js
	var singleLineJsx = <h1>Simple JSX</h1>;

	// good, when single line
	render() {
	  const body = <div>hello</div>;
	  return <MyComponent>{body}</MyComponent>;
	}
	```

### 自闭合标签

- JSX 中所有标签**必须闭合**；
- 没有子元素的组件使用自闭合语法，自闭合标签 **`/` 前留一个空格**。

```js
// bad
<Logo></Logo>
<Logo/>

// very bad
<Foo                 />

// bad
<Foo
 />

// good
<Logo />
```

### 组件内部代码组织

- **不要使用下划线前缀**命名 React 组件的方法；

	```js
	// bad
	React.createClass({
	  _onClickSubmit() {
	    // do stuff
	  }

	  // other stuff
	});

	// good
	React.createClass({
	  onClickSubmit() {
	    // do stuff
	  }

	  // other stuff
	});
	```
- 按照生命周期组顺序织组件的方法、属性；
- 方法（属性）之间空一行；
- `.render()` 方法始终放在最后；
- 自定义方法 React API 方法之后、`.render()` 之前。


	```js
	// React 组件中按照以下顺序组织代码
	React.createClass({
	  displayName: '',

	  mixins: [],

	  statics: {},

	  propTypes: {},

	  getDefaultProps() {
	    // ...
	  },

	  getInitialState() {
	    // do something
	  },

	  componentWillMount() {
	  	// do something
	  },

	  componentDidMount() {
	    // do something: add DOM event listener, etc.
	  },

	  componentWillReceiveProps() {
	  },

	  shouldComponentUpdate() {},

	  componentWillUpdate() {},

	  componentDidUpdate() {},

	  componentWillUnmount() {
	  	// do something: remove DOM event listener. etc.
	  },

	  // clickHandlers or eventHandlers like onClickSubmit() or onChangeDescription()
	  handleClick() {
	    // ...
	  },

	  // getter methods for render like getSelectReason() or getFooterContent()

	  // Optional render methods like renderNavigation() or renderProfilePicture()

	  render() {
	    // ...
	  }
	});
	```

## 代码校验工具

- [ESLint](https://www.github.com/eslint/eslint)
- [ESLint React Plugin](https://github.com/yannickcr/eslint-plugin-react)


## 参考资源

- [React DOM 术语表](http://facebook.github.io/react/docs/glossary.html)
- [Airbnb React/JSX Style Guide](https://github.com/airbnb/javascript/tree/master/react)
- [驼峰命名法](http://zh.wikipedia.org/wiki/%E9%A7%9D%E5%B3%B0%E5%BC%8F%E5%A4%A7%E5%B0%8F%E5%AF%AB)
- [React 组件规范及生命周期](http://facebook.github.io/react/docs/component-specs.html)
- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- [React 支持的 HTML 标签和属性](http://facebook.github.io/react/docs/tags-and-attributes.html)
- [React 不自动添加 `px` 的 style 属性](http://facebook.github.io/react/tips/style-props-value-px.html)
