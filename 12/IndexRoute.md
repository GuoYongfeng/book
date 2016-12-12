
## IndexRoute

IndexRoute即处理页面初始进入时候的组件展示，等路由切换的时候，再根据其他路由规则进行组件的切换展示。

```
import React, { Component } from 'react';
import { Router, Route, browserHistory, Link, IndexRoute } from 'react-router';

import './App.css';

const Home = (props) =>
  <div>
    <h1>Home</h1>
    <Links />
    {props.children}
  </div>

const About = () =>
  <div>
    <h1>About</h1>
  </div>

const Contact = () =>
  <div>
    <h1>Contact</h1>
  </div>

const Links = () =>
  <nav>
    <Link activeClassName="active" to="/">Home</Link>
    <Link activeClassName="active" to="/contact">Contact</Link>
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={browserHistory}>
        <Route path="/" component={Home}>
          <IndexRoute component={About} />
          <Route path="contact" component={Contact} />
        </Route>
      </Router>
    );
  }
}

export default App;

```
