## 编译ES6代码

安装babel及其相关presets
```
$ npm install babel-core babel-preset-es2015 --save-dev
```

`Install babel-loader:`
```
$ npm install babel-loader --save-dev
```

创建babel的配置文件.babelrc
```
$ touch .babelrc
```

配置.babelrc
```
{
	"presets": ["es2015"]
}
```

修改webpack.config.js
```
 module.exports = {
     entry: './src/entry.js',
     output: {
         path: './dist',
         filename: 'bundle.js',
     },
     module: {
         loaders: [{
             test: /\.js$/,
             exclude: /node_modules/,
             loader: 'babel'
         }]
     }
 }
```

下载jquery和babel-polyfill，准备使用jq来写一个示例，由于jq和babel-polyfill是运行时使用的，所以我们在install的时候加上--save参数来替代--save-dev
```
$ npm install --save jquery babel-polyfill
```

创建cats.js
```
$ cd src && touch cats.js
```

编辑cats.js

```
var cats = ['dave', 'henry', 'martha'];
module.exports = cats;
```
编辑`src/entry.js`
```
 import 'babel-polyfill';
 import cats from './cats.js';
 import $ from 'jquery';

 $('<h1>Cats</h1>').appendTo('body');
 const ul = $('<ul></ul>').appendTo('body');
 for (const cat of cats) {
     $('<li></li>').text(cat).appendTo(ul);
 }
```

运行
```
$ npm run dev
```
