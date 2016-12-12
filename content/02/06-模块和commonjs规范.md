

## Nodejs模块概述

> nodejs的模块分为提供的核心模块以及我们编写的业务模块

### 加载模块

Node.js采用模块化结构，按照CommonJS规范定义和使用模块。模块与文件是一一对应关系，即加载一个模块，实际上就是加载对应的一个模块文件。

require方法的参数是模块文件的名字。它分成两种情况。

第一种情况是参数中含有文件路径，这时路径是相对于当前脚本所在的目录：

```
var myfile = require('./myfile.js');
```

第二种情况是参数中不含有文件路径，这时Node到模块的安装目录，去寻找已安装的模块（比如下例）。

```
var gulp = require('gulp');
```

### 核心模块

如果只是在服务器运行JavaScript代码，用处并不大，因为服务器脚本语言已经有很多种了。Node.js的用处在于，它本身还提供了一系列功能模块，与操作系统互动。这些核心的功能模块，不用安装就可以使用，下面是它们的清单。

```
http：提供HTTP服务器功能。
url：解析URL。
fs：与文件系统交互。
querystring：解析URL的查询字符串。
child_process：新建子进程。
util：提供一系列实用小工具。
path：处理文件路径。
crypto：提供加密和解密功能，基本上是对OpenSSL的包装。
```

上面这些核心模块，源码都在Node的lib子目录中。为了提高运行速度，它们安装时都会被编译成二进制文件。

核心模块总是最优先加载的。如果你自己写了一个HTTP模块，`require('http')`加载的还是核心模块。


### 自定义模块

Node模块采用CommonJS规范。只要符合这个规范，就可以自定义模块。

下面是一个最简单的模块，假定新建一个test.js文件，写入以下内容。

```
module.exports = function(str) {
    alert(str);
};
```

上面代码就是一个模块，它通过module.exports变量，对外输出一个方法。

这个模块的使用方法如下。

```
var test = require('./test');

test("hello world");
```

上面代码通过require命令加载模块文件test.js（后缀名省略）。


## commonjs代码规范说明

也许你对上面的代码有所好奇，所以我们就来简单分析下以上代码。

首先，Node程序它是由许多个模块组成的，每个模块就是一个文件。Node模块采用了CommonJS规范。

根据CommonJS规范，一个单独的文件就是一个模块。每一个模块都是一个单独的作用域，也就是说，在一个文件定义的变量（还包括函数和类），都是私有的，对其他文件是不可见的。

而且，CommonJS规定，每个文件的对外接口是module.exports对象。这个对象的所有属性和方法，都可以被其他文件导入。

如下，我们来定义一个模块

```javascript
var x = 5;

var addX = function(value) {
  return value + x;
};

// 导出变量和方法
module.exports.x = x;
module.exports.addX = addX;
```

理解：上面代码通过module.exports对象，定义对外接口，输出变量x和函数addX。module.exports对象是可以被其他文件导入的，它其实就是文件内部与外部通信的桥梁。

好，继续，我们来引用刚才定义的模块
```javascript
var example = require('./example.js');

console.log(example.x); // 5
console.log(addX(1)); // 6
```

### module对象
每个模块内部，都有一个module对象，代表当前模块。它有以下属性。
```
module.id 模块的识别符，通常是带有绝对路径的模块文件名。
module.filename 模块的文件名，带有绝对路径。
module.loaded 返回一个布尔值，表示模块是否已经完成加载。
module.parent 返回一个对象，表示调用该模块的模块。
module.children 返回一个数组，表示该模块要用到的其他模块。
```
- module.exports属性
module.exports属性表示当前模块对外输出的接口，其他文件加载该模块，实际上就是读取module.exports变量。

- exports变量
为了方便，Node为每个模块提供一个exports变量，指向module.exports。这等同在每个模块头部，有一行这样的命令。
### require命令的解读
Node.js使用CommonJS模块规范，内置的require命令用于加载模块文件。

require命令的基本功能是，读入并执行一个JavaScript文件，然后返回该模块的exports对象。如果没有发现指定模块，会报错。

```
// example.js
var invisible = function () {
  console.log("invisible");
}

exports.message = "hi";

exports.say = function () {
  console.log(message);
}
```

### require加载模块的规则
require命令用于加载文件，可以加载后缀名为`.js` `.json` `.node`的文件，比如：
```
var foo = require('foo');
//  等同于
var foo = require('foo.js');
```

举例来说，脚本/home/user/projects/foo.js执行了require('bar.js')命令，Node会依次搜索以下文件。
```
/usr/local/lib/node/bar.js
/home/user/projects/node_modules/bar.js
/home/user/node_modules/bar.js
/home/node_modules/bar.js
/node_modules/bar.js
```
这样设计的目的是，使得不同的模块可以将所依赖的模块本地化。

如果指定的模块文件没有发现，Node会尝试为文件名添加.js、.json、.node后，再去搜索。.js件会以文本格式的JavaScript脚本文件解析，.json文件会以JSON格式的文本文件解析，.node文件会以编译后的二进制文件解析。

require匹配文件的流程图例

![](../images/require.jpg)
