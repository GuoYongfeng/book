
## Modules 

在ES6标准中，JavaScript原生支持module了。这种将JS代码分割成不同功能的小块进行模块化的概念是在一些三方规范中流行起来的，比如CommonJS和AMD模式。

将不同功能的代码分别写在不同文件中，各模块只需导出公共接口部分，然后通过模块的导入的方式可以在其他地方使用。

不过，还是有很多细节的地方需要注意，我们看例子：

简单使用方式：
```
// point.js
export class Point {
     constructor (x, y) {
         public x = x;
         public y = y;
     }
 }


// myapp.js
//这里可以看出，尽管声明了引用的模块，还是可以通过指定需要的部分进行导入
import Point from "point";

var origin = new Point(0, 0);
console.log(origin);
```

### export

```
// demo1：简单使用
export var firstName = 'Michael';
export var lastName = 'Jackson';
export var year = 1958;

// 等价于
var firstName = 'Michael';
var lastName = 'Jackson';
var year = 1958;

export {firstName, lastName, year};
```

```
// demo2：还可以这样
function v1() { ... }
function v2() { ... }

export {
  v1 as streamV1,
  v2 as streamV2,
  v2 as streamLatestVersion
};
```

```
// demo3：需要注意的是

// 报错
function f() {}
export f;

// 正确
export function f() {};

```

我们再来看一下export的默认输出：

```
export default function () {
  console.log('foo');
}
```

为了给用户提供方便，让他们不用阅读文档就能加载模块，就要用到export default命令，为模块指定默认输出。这样其他模块加载该模块时，import命令可以为该匿名函数指定任意名字。

需要注意的是，这时import命令后面，不使用大括号。


最后需要强调的是：ES6模块加载的机制，与CommonJS模块完全不同。CommonJS模块输出的是一个值的拷贝，而ES6模块输出的是值的引用。

- CommonJS模块输出的是被输出值的拷贝，也就是说，一旦输出一个值，模块内部的变化就影响不到这个值。

- ES6模块的运行机制与CommonJS不一样，它遇到模块加载命令import时，不会去执行模块，而是只生成一个动态的只读引用。等到真的需要用到时，再到模块里面去取值，换句话说，ES6的输入有点像Unix系统的”符号连接“，原始值变了，import输入的值也会跟着变。因此，ES6模块是动态引用，并且不会缓存值，模块里面的变量绑定其所在的模块。


### import

```
// 1
import $ from 'jquery';

// 2
import {firstName, lastName, year} from './profile';

// 3
import React, { Component, PropTypes } from 'react';

// 4
import * as React from 'react';

```
