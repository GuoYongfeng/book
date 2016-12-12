
## activeStyle,activeClassName

当前路由被点击处于触发显示状态的时候，我们可以使用activeStyle来给路由设置一些颜色。

```
import React, { Component } from 'react';
import { Router, Route, browserHistory, Link } from 'react-router';

const Home = () => <div><h1>Home</h1><Links /></div>;
const About = () => <div><h1>About</h1><Links /></div>;
const Contact = () => <div><h1>Contact</h1><Links /></div>;

const Links = () =>
  <nav>
    <Link activeStyle={{color: 'red'}} to="/">Home</Link>
    <Link activeStyle={{color: 'red'}} to="/about">About</Link>
    <Link activeStyle={{color: 'red'}} to="/contact">Contact</Link>
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={browserHistory}>
        <Route path="/" component={Home} />
        <Route path="/about" component={About} />
        <Route path="/contact" component={Contact} />
      </Router>
    );
  }
}

export default App;

```

同理，我们还可以使用activeClassName来将路由激活状态的样式抽取出来。

我们在App.css写一个样式，代码清单：`app/containers/App/App.jsx`
```
.active {
  color: red;
}
```

然后修改App.jsx
```
import React, { Component } from 'react';
import { Router, Route, browserHistory, Link } from 'react-router';

import './App.css';

const Home = () => <div><h1>Home</h1><Links /></div>;
const About = () => <div><h1>About</h1><Links /></div>;
const Contact = () => <div><h1>Contact</h1><Links /></div>;

const Links = () =>
  <nav>
    <Link activeClassName="active" to="/">Home</Link>
    <Link activeClassName="active" to="/about">About</Link>
    <Link activeClassName="active" to="/contact">Contact</Link>
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={browserHistory}>
        <Route path="/" component={Home} />
        <Route path="/about" component={About} />
        <Route path="/contact" component={Contact} />
      </Router>
    );
  }
}

export default App;

```
