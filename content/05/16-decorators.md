
## Decorator
修饰器（Decorator）是一个表达式，用来修改类的行为。这是ES7的一个提案，目前Babel（babel-plugin-transform-decorators-legacy）转码器已经支持。

不知道大家有没有使用过java的spring mvc，其中的注解就跟这个比较相似，学习React的话可以重点关注下这个语法，因为后面使用redux类库的时候会频繁的用到decorator。

首先说下如何配置babel的插件来进行decorator的解析。
```
// 官网提供了babel-plugin-transform-decorators这个插件来解析，但是我发现不work，就找了下面这个
$ npm install babel-plugin-transform-decorators-legacy --save-dev
```
配置`.babelrc`的plugins字段。
```
{
  "presets": ["es2015", "react", "stage-0"],
  "plugins": ["transform-decorators-legacy"]
}

```

ok，接下来来段使用decorator的示例代码
```
function testable(target) {
  target.isTestable = true;
}

@testable
class MyTestableClass {}

console.log(MyTestableClass.isTestable) // true
```
