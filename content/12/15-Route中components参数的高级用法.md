## Route中components参数的高级用法

Route中components中接收的参数不仅仅只是实际的组件，还可以是对象，通过这样的用法，我们可以更灵活的控制组件的展示。

```JavaScript
import React, { Component } from 'react';
import { Router, Route, hashHistory, Link, IndexRoute } from 'react-router';

import './App.css';

const HomeHeader = () => <h1>HomeHeader</h1>
const HomeBody = () => <h1>HomeBody</h1>
const AboutHeader = () => <h1>AboutHeader</h1>
const AboutBody = () => <h1>AboutBody</h1>

const Container = (props) =>
  <div>
    {props.header}
    {props.body}
    <Links />
  </div>

const Links = () =>
  <nav>
    <Link to="/">Hello</Link>
    <Link to="/about">About</Link>
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={hashHistory}>
        <Route path="/" component={Container}>
          <IndexRoute components={{ header:HomeHeader, body:HomeBody }} />
          <Route path="about" components={{ header:AboutHeader, body:AboutBody }} />
        </Route>
      </Router>
    );
  }
}

export default App;

```
