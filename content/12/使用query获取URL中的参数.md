
# 使用query获取URL中的参数

我们可以将URL中访问的参数获取，并且应用到组件中。

``` javascript
import React, { Component } from 'react';
import { Router, Route, hashHistory, Link, IndexRoute } from 'react-router';

import './App.css';

const Page = (props) =>
  <div>
    <h1>{props.location.query.message || 'Hello'}</h1>
  </div>

class App extends Component {
  render() {
    return (
      <Router history={hashHistory}>
        <Route path="/" component={Page} />
      </Router>
    );
  }
}

export default App;

```

然后在url中输入`http://localhost:8080/#/?message=guoyongfeng`，页面中就会显示`guoyongfeng`。

**另外，我们还可以在Link组件中设置pathname和query变量**

``` javascript
import React, { Component } from 'react';
import { Router, Route, hashHistory, Link, IndexRoute } from 'react-router';

import './App.css';

const Page = (props) =>
  <div>
    <h1>{props.location.query.message || 'Hello'}</h1>
  </div>

const Links = () =>
  <nav>
    <Link to={ pathname: "/", query: {message: "guoyongfeng"} } />
  </nav>

class App extends Component {
  render() {
    return (
      <Router history={hashHistory}>
        <Route path="/" component={Page} />
      </Router>
    );
  }
}

export default App;

```
