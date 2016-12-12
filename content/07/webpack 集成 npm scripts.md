## webpack 集成 npm scripts

```
$ npm init
$ npm install webpack --save-dev
# 或者安装指定版本
$ npm install webpack@1.2.x --save-dev
$ mkdir src && mv entry.js src
```

修改`package.json`
```
scripts: {
	"dev": "webpack --colors --progress --watch"
}
```

解读
```
progress 编译进度
colors 编译产出的命令行颜色
watch 持续监听编译过程
```

### `webpack.config.js`

创建webpack.config.js，该文件是webpack的配置文件，可以将webpack的相关配置都在该文件中配置。
```
var path = require('path');

module.exports = {
    entry: "./src/entry.js",
    output: {
        path: path.resolve(__dirname, './dist'),
        filename: "bundle.js"
    }
};
```

`index.html`
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Webpack 完全教程</title>
</head>
<body>
  <script src="./dist/bundle.js"></script>
</body>
</html>

```

执行npm
```
$ npm run dev
```
