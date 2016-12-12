
## Link

Link是react-router提供的导航组件，可以直接使用进行路由切换

代码清单：`app/container/App/App.jsx`
```
import React, { Component } from 'react';
import { Router, Route, hashHistory, Link } from 'react-router';

const Home = () => <div><h1>Home</h1><Links /></div>;
const About = () => <div><h1>About</h1><Links /></div>;
const Contact = () => <div><h1>Contact</h1><Links /></div>;

const Links = () =>
  <nav>
    <Link to="/">Home</Link>
    <Link to="/about">About</Link>
    <Link to="/contact">Contact</Link>
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={hashHistory}>
        <Route path="/" component={Home} />
        <Route path="/about" component={About} />
        <Route path="/contact" component={Contact} />
      </Router>
    );
  }
}

export default App;

```
