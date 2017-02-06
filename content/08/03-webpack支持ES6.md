# webpack 支持ES6

## Javascript包管理格式

Javascript中的包管理比较常见的有几种方式：

#### CommonJS

```
//CommonJS 定义的是模块的同步加载，主要用于NodeJS

var MyModule = require('./MyModule');

// export at module root
module.exports = function() { ... };

// alternatively, export individual functions
exports.hello = function() {...};

```

#### AMD

```
//AMD 是异步加载，比如require.js使用这种规范
define(['./MyModule.js'], function (MyModule) {
  // export at module root
  return function() {};
});

// or
define(['./MyModule.js'], function (MyModule) {
  // export as module function
  return {
    hello: function() {...}
  };
});

```

#### ES6
```
//ES6 变得越来越主流了

import MyModule from './MyModule.js';

// export at module root
export default function () { ... };

// or export as module function,
// you can have multiple of these per module
export function hello() {...};

```

还有其他格式如UMD、CMD等，在此不再一一介绍。webpack对这些模块格式都可以很好的支持。在我们之前的项目中使用的是CommonJS格式的模块管理，但是随着ES6的普及和应用，同时得益于强大的[Babel](https://babeljs.io/)的存在，使我们可以方便的使用ES6的语法，而不必考虑浏览器支持的问题。

## webpack支持ES6语法

在webpack中支持ES6同样只需要安装配置相应的loader就可以了。

安装如下：

```
npm install babel-loader babel-core babel-preset-es2015 babel-preset-react --save-dev
```

在`webpack.config.js`中添加loader如下：
```
  {
    test: /\.jsx?$/,
    loader: 'babel',
    exclude: /node_modules/,
    query: {
      presets: ['react', 'es2015']
    }
  }
```
由于后边需要支持React的jsx文件，所以我们在这里安装了`babel-preset-react`。

顺便提一下，我们可以在项目根目录下创建一个`.babelrc`文件，将loader中的`presets`放在文件`.babelrc`中：
```
# .babelrc
{
  "presets": ["react", "es2015"]
}
```

此时我们运行`npm run build`，正常编译后，使用`npm run dev`，启动web服务器，打开 http://localhost:3000/ 可以看到页面已经可以正常显示了。

##### 踩坑提醒

如果上面对于loader的配置写为（注意这里是`loaders`不是`loader`）：
```
{
    test: /\.jsx?$/,
    loaders: ['babel'],
    exclude: /node_modules/,
    query: {
      presets: ['es2015', 'react']
    }
}
```
则可能会出现这样的错误：
```
$ npm run build

> webpack-dev-boilerplate@1.0.0 build D:\node\webpack-dev-boilerplate
> webpack

D:\node\webpack-dev-boilerplate\node_modules\webpack-core\lib\LoadersList.js:54
                if(!element.loader || element.loader.indexOf("!") >= 0) throw new Error("Cannot define 'query' and multiple loaders in loaders list");
                                                                        ^

Error: Cannot define 'query' and multiple loaders in loaders list
    at getLoadersFromObject (D:\node\webpack-dev-boilerplate\node_modules\webpack-core\lib\LoadersList.js:54:65)
    at LoadersList. (D:\node\webpack-dev-boilerplate\node_modules\webpack-core\lib\LoadersList.js:78:12)
    at Array.map (native)
    at LoadersList.match
    ...

```

原因是使用了多个`loader`，而`query`仅仅作用于`babel-loader`。如果非要使用`loaders`加载多个`loader`，可以做如下修改：
```
var babelPresets = {presets: ['react', 'es2015']};
......
loaders: ['other-loader', 'babel-loader?'+JSON.stringify(babelPresets)]
......
```
