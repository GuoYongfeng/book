## 使用UglifyJs Plugin压缩资源

```
const webpack = require('webpack');

module.exports = {
    entry: './src/entry.js',
    output: {
        path: './dist',
        filename: 'bundle.js',
    },
    module: {
        loaders: [{
            test: /\.js?$/,
            exclude: /node_modules/,
            loader: 'babel',
        }]
    },
    plugins: [
        new webpack.optimize.UglifyJsPlugin({
            compress: {
                warnings: false,
            },
            output: {
                comments: false,
            },
        }),
    ]
}
```

运行
```
$ npm run dev
```
