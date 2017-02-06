# 在项目中支持使用React

关于React的介绍和基本概念相信你已经有所了解，如果需要，可以参考本文最后的“参考阅读”中的链接，在此不再详述。

## 安装React

```
npm install react react-dom --save
```

这里我们使用的版本是15.0.1。
```
$ npm install react react-dom --save
webpack-dev-boilerplate@1.0.0 D:\node\webpack-dev-boilerplate
+-- react@15.0.1
| `-- fbjs@0.8.1
|   +-- isomorphic-fetch@2.2.1
|   | +-- node-fetch@1.5.1
|   | | +-- encoding@0.1.12
|   | | | `-- iconv-lite@0.4.13
|   | | `-- is-stream@1.1.0
|   | `-- whatwg-fetch@0.11.0
|   `-- ua-parser-js@0.7.10
`-- react-dom@15.0.1
```

## 改造项目结构

在项目中我们使用了html-webpack-plugin插件来用webpack自动生成入口的index.html文件，但是里面的内容我们没法控制。html-webpack-plugin提供了一种模板的机制，可以让我们对生成的文件内容进行定制。

### 创建模板文件

我们使用一个新的目录templates用于存放模板文件，新建一个index.ejs文件：

##### templates/index.ejs
```




    <%= htmlWebpackPlugin.options.title %>


  Welcome to New Page



```

### 修改 html-webpack-plugin 设置

修改`webpack.config.js`文件如下：
```
  plugins: [
    new HtmlwebpackPlugin({
      title: 'React Biolerplate by Linghucong',
      template: path.resolve(__dirname, 'templates/index.ejs'),
      inject: 'body'
    })
  ]
```

关于 html-webpack-plugin 更多高级用法可以[参考其项目主页](https://github.com/ampedandwired/html-webpack-plugin)。

### 支持sourcemap

sourcemap的作用各位自行Google吧。要生成编译出的js文件的sourcemap文件，只需要在webpack配置文件中加入如下一行配置即可：
```
devtool: 'source-map',
```

运行`npm run build`可以看到一个会在`dist`目录生成一个新的文件`bundle.js.map`，这就是sourcemap文件。

### Minification 代码压缩

要对生成的js文件进行压缩，需要使用一个新的插件：UglifyJsPlugin。
修改`webpack.config.js`如下：

```
......
var UglifyJsPlugin = webpack.optimize.UglifyJsPlugin;

var config = {
......
  plugins: [
    ......
    new UglifyJsPlugin({ minimize: true })
  ]
}

module.exports = config;
```
运行`npm run build`可以看到生成的bundle.js文件已经被minify了。

在实际的项目开发中，我们在开发阶段一般不需要将代码minify，因为压缩之后很不方便调试。因此，我们有必要将开发模式和发布模式区分开。我们通过设置`process.env.WEBPACK_ENV`来做区分。
修改`webpack.config.js`如下：
```
......
var env = process.env.WEBPACK_ENV;
var outputFile;
var plugins = [new HtmlwebpackPlugin({
      title: 'React Biolerplate by Linghucong',
      template: path.resolve(__dirname, 'templates/index.ejs'),
      inject: 'body'
    })];

if (env === 'build') {
  var UglifyJsPlugin = webpack.optimize.UglifyJsPlugin;
  plugins.push(new UglifyJsPlugin({ minimize: true }));
  outputFile = 'bundle.min.js';
} else {
  outputFile = 'bundle.js';
}

var config = {
......
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: outputFile
  },
......
  plugins: plugins
}

module.exports = config;
```
同时需要修改npm run的快捷方式，在`package.json`文件中修改如下：
```
  "scripts": {
    "dev": "WEBPACK_ENV=dev webpack-dev-server --port 3000 --devtool eval --progress --colors --hot --content-base dist",
    "build": "WEBPACK_ENV=build webpack"
  },
```

##### 踩坑提醒

在Windows系统上不能像上述那样设置`WEBPACK_ENV`，可以使用`set`来设置，如下：

```
  "scripts": {
    "test": "mocha --compilers js:babel-register --require ./test/test_helper.js --recursive ./test",
    "test:watch": "npm test -- --watch",
    "dev": "set WEBPACK_ENV=dev&&webpack-dev-server --port 3000 --devtool eval --progress --colors --hot --content-base dist",
    "build": "set WEBPACK_ENV=build&&webpack"
  },
```

### 更新项目代码

对我们的组件稍作修改：
```
import './index.less';

import component from './component';

let content = document.getElementById("content");
content.appendChild(component());
```

然后编译，运行：
```
$ npm run build
$ npm run dev
```

可以看到，目前访问 http://localhost:3000/ 的页面显示已经发生了变化。
![linghucong](http://7xsxyo.com1.z0.glb.clouddn.com/2016/04/29/FhsJFMi-612vNsHQhDgwt8abvfKB814.jpg)

通过查看源代码，可以看到我们页面正是应用了我们的模板文件。

![source](http://7xsxyo.com1.z0.glb.clouddn.com/2016/04/29/FryFP8lTIrAosvDBBFT5h5nznmuH814.jpg)

## 创建React组件

我们将`app/index.js`修改一下，创建一个新的React组件。

##### app/index.js
```
import React from 'react';
import ReactDOM from 'react-dom';

class HelloReact extends React.Component {
  render() {
    return Hello React!
  }
}

ReactDOM.render(, document.getElementById('content'));
```

代码十分简单，引入了`react`和`react-dom`，创建了一个叫做HelloReact的组件，并将其渲染到页面上id为`content`的DOM元素内。

## 编译React代码

我们在之前已经在webpack的配置中配置好了对React的支持，因此目前不需要做什么修改了。

`npm run build`之后就可以在页面上看到“Hello React!”了。
