
## Router,hashHistory,Route

首先下载react-router
```
$ npm install react-router --save
```

需要注意的是，react-router更新很快，API也在持续升级，也许你看到市面很多教程，但可能那还是1.x甚至是0.x版本的。



我们首先在App.jsx写一个简单示例，让你快速的对react-router有印象。

代码清单：`app/container/App/App.jsx`
```JavaScript
import React, { Component } from 'react';
import { Router, Route, hashHistory } from 'react-router';

const Home = () => <div><h1>Home</h1></div>;
const About = () => <div><h1>About</h1></div>;
const Contact = () => <div><h1>Contact</h1></div>;

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
