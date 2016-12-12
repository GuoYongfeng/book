# 使用Karma测试

## karma安装与配置

Karma是一个基于Node.js的前端测试启动器（Test Runner），它出自Google的Angularjs团队。该工具可用于测试所有主流Web浏览器，可以支持Chrome、Safari、Firefox、IE、Opera甚至PhantomJS。

安装Karma：

```
npm install karma --save-dev
```

然后还需要安装我们需要用到的一些依赖库：
```
npm install lolex phantomjs-prebuilt phantomjs --save-dev

npm install karma-chai karma-chai-plugins karma-chai-sinon karma-mocha karma-mocha-reporter karma-phantomjs-launcher karma-sinon karma-sinon-chai karma-sourcemap-loader karma-webpack --save-dev
```

##### 踩坑提醒

不要问我为什么装那么多扩展，因为我踩过很多坑，这里就直接跳过了:<

然后我们就可以使用karma命令来生成一个配置文件。

```
λ .\node_modules\.bin\karma.cmd init karma.conf.js

Which testing framework do you want to use ?
Press tab to list possible options. Enter to move to the next question.
> mocha

Do you want to use Require.js ?
This will add Require.js plugin.
Press tab to list possible options. Enter to move to the next question.
> no

Do you want to capture any browsers automatically ?
Press tab to list possible options. Enter empty string to move to the next question.
> PhantomJS
> Chrome
>

What is the location of your source and test files ?
You can use glob patterns, eg. "js/*.js" or "test/**/*Spec.js".
Enter empty string to move to the next question.
> app/*.js
> test/*.spec.js
>

Should any of the files included by the previous patterns be excluded ?
You can use glob patterns, eg. "**/*.swp".
Enter empty string to move to the next question.
>

Do you want Karma to watch all the files and run the tests on change ?
Press tab to list possible options.
> yes


Config file generated at "D:\node\webpack-dev-boilerplate\karma.conf.js".
```

然后我们就可以使用`karma start`命令来运行我们的测试用例了。不过现在直接运行可能还有一些问题，暂时先不管。

## 优化Karma配置文件

我们使用一个单独的文件`test.webpack.js`来保存测试文件的路径，方便在karma设置中进行预处理。新建文件`test.webpack.js`如下：

```
function requireAll(requireContext) {
  return requireContext.keys().map(requireContext);
}

var modules = requireAll(require.context("./test", true, /.+\.spec\.jsx?$/));

module.exports = modules
```
然后修改`karma.config.js`:
```
var webpackConfig = require('./webpack.config');
webpackConfig.devtool = 'inline-source-map';

module.exports = function (config) {
  config.set({
    browsers: [ 'PhantomJS' ],
    singleRun: true,
    frameworks: [ 'mocha', 'chai', 'sinon', 'sinon-chai' ],
    files: [
      'test.webpack.js'
    ],
    plugins: [
      'karma-phantomjs-launcher',
      'karma-chrome-launcher',
      'karma-chai',
      'karma-mocha',
      'karma-sourcemap-loader',
      'karma-webpack',
      'karma-mocha-reporter',
      'karma-sinon',
      'karma-sinon-chai'
    ],
    preprocessors: {
      'test.webpack.js': [ 'webpack', 'sourcemap' ]
    },
    reporters: [ 'mocha' ],
    webpack: webpackConfig,
    webpackServer: {
      noInfo: true
    },
    autoWatch: true
  });
};
```
## 运行Karma

好了，到现在为止，我们可以正常运行我们的测试用例了。使用命令`karma start`运行结果如下：

```
$ karma start

START:
29 04 2016 13:26:50.350:INFO [karma]: Karma v0.13.22 server started at http://localhost:9876/
29 04 2016 13:26:50.375:INFO [launcher]: Starting browser PhantomJS
29 04 2016 13:26:52.072:INFO [PhantomJS 2.1.1 (Windows 8 0.0.0)]: Connected on socket /#05AECTTMgBTkXK4kAAAA with id 76498752
  hello react spec
    √ works!!!

Finished in 0.008 secs / 0.001 secs

SUMMARY:
√ 1 test completed
```
可以看到，测试用例测试通过了。

目前我们在karma的配置文件中设置的浏览器类型是“browsers: [ 'PhantomJS' ]”，也就是会使用PhantomJS来运行。如果需要使用其他浏览器，可以做相应修改，甚至添加多个。比如我们要支持打开Chrome浏览器运行测试，修改如下：
```
browsers: [ 'Chrome' ]
```
正常运作的前提是，必须事先安装好了对应的插件，对应Chrome的就是'karma-chrome-launcher'，其他浏览器类型类似处理。

## 添加karma快捷方式到npm

我们之前使用`npm run test`来运行测试，`npm run test:watch`来监听文件改变并运行测试。使用karma之后，需要在`package.json`中作如下修改：
```
  "scripts": {
    "test": "karma start",
    "test:watch": "watch \"npm run test\" app/",
    ......
  }
```
另外需要安装一个npm包：
```
npm install watch --save-dev
```

这样我们就可以使用`npm run test`来运行测试，`npm run test:watch`来监听文件改变并自动运行测试了：

![karma](http://7xsxyo.com1.z0.glb.clouddn.com/2016/04/29/Fo8y7n8p4qhOi9Bq0gf3pXE-xrJQ87.jpg)
