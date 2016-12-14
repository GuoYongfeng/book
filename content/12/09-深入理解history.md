
## browserHistory

browserHistory和hashHistory不一样，使用browserHistory的时候，浏览器中导航栏的URL就不会出现_k的hash键值对。实际项目中也一般用browserHistory.

```JavaScript
import React, { Component } from 'react';
import { Router, Route, browserHistory, Link } from 'react-router';

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

这样正常点击路由切换没有问题，但是重新刷新URL就会报找不到路由，这个时候我们在webpack-dev-server启动的时候需要加上参数`--history-api-fallback`。
