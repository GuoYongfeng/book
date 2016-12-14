
## Redirect重定向

```JavaScript
import React, { Component } from 'react';
import { Router, Route, hashHistory, Link, Redirect } from 'react-router';

const Home = () => <div><h1>Home</h1><Links /></div>;
const About = () => <div><h1>About</h1><Links /></div>;
const Contact = () => <div><h1>Contact</h1><Links /></div>;

const Links = () =>
  <nav>
    <Link to="/">Home</Link>
    <Link to="/about">About</Link>
    <Link to="/contact">Contact</Link>
    <Link to="/contact-us">Contact US</Link>
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={hashHistory}>
        <Route path="/" component={Home} />
        <Route path="/about" component={About} />
        <Route path="/contact-us" component={Contact} />
        <Redirect from="/contact" to="/contact-us" />
      </Router>
    );
  }
}

export default App;

```
