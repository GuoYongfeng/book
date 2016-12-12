## 编译css资源

`install`
```
$ npm install --save-dev style-loader css-loader
```

`webpack.config.js`
```
module.exports = {
    entry: "./entry.js",
    output: {
        path: __dirname,
        filename: "bundle.js"
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style!css" }
        ]
    }
};
```

创建css文件
```
$ touch style.css
```

编辑style.css
```
.demo {
	font-size: 20px;
}
```

编辑`entry.js`
```
import './style.css';

document.write('webpack编译css资源');
```

编辑`index.html`
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Webpack 完全教程</title>
</head>
<body>
  <p class="demo">用友网络FED团队</p>
  <script src="./bundle.js"></script>
</body>
</html>
```

运行
```
$ npm run dev
```
### 编译less文件

`install`
```
$ npm install less less-loader --save-dev
```

`webpack.config.js config`
```
module: {
	loaders: [
		{
        test: /\.less$/,
        include: __dirname + /src/,
        loader: 'style!css!less'
      },
	]
}

```
## CSS Module的实现

`CSS Module` 是为了解决SPA中css作用域污染的问题。

`webpack.config.js`
```
module: {
  loaders: [{
    test: /\.css$/,
    loaders: [
      'style-loader',
      'css-loader?modules&localIdentName=[name]__[local]___[hash:base64:5]',
      'postcss-loader'
    ]
  }]
},
postcss: [
  require('postcss-nested')(),
  require('cssnext')(),
  require('autoprefixer-core')({ browsers: ['last 2 versions'] })
]
```
然后把下面的代码交给 webpack：

`js`
```
import styles from './ChatMessage.css';

class ChatMessage extends React.Component {
  render() {
    return (
      <div className={styles.root}>
        <img src="http://very.cute.png" />
        <p className={styles.text}> woooooow </p>
      </div>
    );
  }
}
```

`css`
```
.root {
  background-color: #f0f0f0;
  > img {
    width: 32px;
    height: 32px;
    border-radius: 16px;
  }
}

.text {
  font-size: 22px;
}
```

最后输出

`HTML`
```
<div class="ChatMessage__root__1aF8de0">
  <img src="http://very.cute.png" />
  <p class="ChatMessage__text__fo40mmi"> woooooow </p>
</div>
```

`CSS`
```
.ChatMessage__root__1aF8de0 {
  background-color: #f0f0f0;
}
.ChatMessage__root__1aF8de0 > img {
  width: 32px;
  height: 32px;
  border-radius: 16px;
}
.ChatMessage__text__fo40mmi {
  font-size: 22px;
}
```

我们通过编译期 renaming 的方式为 CSS 引入了局部变量。

## sass 编译

`install`
```
$ npm install node-sass sass-loader --save-dev
```

`webpack.config.js config`
```
module: {
	loaders: [
		{
        test: /\.scss$/,
        include: __dirname + /src/,
        loader: 'style!css!sass'
      },
	]
}

```

## css文件单独加载

通过上面的例子，css文件的引入、解析、运行已经跑通，BUT，目前我们的css文件全部被打包在bundle.js一个文件里面。这可不是一件好事，后续代码量一上来，文件越来越胖，我想老板一定会抓你去做性能优化的，所以，我们需要把css文件单独打包出来。

extract-text-webpack-plugin插件可以帮助我们解决这个问题，现在让我们先来下载。
```
$ npm install extract-text-webpack-plugin --save-dev
```

然后配置webpack。
代码清单：`webpack.config.js`
```
var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
    entry: [
      'webpack/hot/dev-server',
      'webpack-dev-server/client?http://localhost:8080',
      path.resolve(__dirname, 'src/index.js')
    ],
    output: {
        path: path.resolve(__dirname, 'build'),
        filename: 'bundle.js',
    },
    resolve: {
      extension: ['', '.js', '.jsx', '.json']
    },
    module: {
      loaders: [
        {
          test: /\.js$/,
          loaders: ['react-hot', 'babel'],
          exclude: path.resolve(__dirname, 'node_modules')
        },
        {
          test: /\.css/,
          loader: ExtractTextPlugin.extract("style-loader", "css-loader")
        },
        {
          test: /\.less/,
          loader: ExtractTextPlugin.extract("style-loader", "css-loader!less-loader")
        }
      ]
    },
    plugins: [
      new webpack.HotModuleReplacementPlugin(),
      new webpack.NoErrorsPlugin(),
      new ExtractTextPlugin("bundle.css")
    ]
};
```

同时，也需要在我们的index.html去引入bundle.css文件。
代码清单：`build/index.html`
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>React Demo</title>
  <link rel="stylesheet" href="bundle.css">
</head>
<body>
  <div id="app"></div>
  <script src="bundle.js"></script>
</body>
</html>
```

执行`npm run dev`后你就可以在浏览器中看到加载的分离后的css文件了。

另外这里手动去修改index.html是一个不是很友好的体验，这里暂且按下不表，后续我们会通过插件来统一生成build下的资源，这样让调试和部署更加便捷。
