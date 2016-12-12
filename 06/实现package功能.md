
## 编写模块

### 功能描述

该模块是一个主要功能是根据一个URL来下载文件到本地，或者本地直接文件的复制，同时提供下载/复制进度信息。其使用方法如下：

```javascript
let download = require('lei-download');

let source = '一个URL或者本地文件名';
let target = '要存储到的本地位置，null|false|undefined表示自动生成一个临时文件';
// 用于获取进度通知的函数，可以省略
let progress = (size, total) => console.log(`进度：${size}/${total}`);

download(source, target, progress)
  .then(filename => console.log(`已保存到：${filename}`))
  .catch(err => console.log(`出错：${err}`));

// 也可以使用callback模式
download(source, target, progress, (err, filename) => {
  if (err) console.log(`出错：${err}`);
  else console.log(`已保存到：${filename}`);
});
```

在编写模块时，我们首先要实现以下两个函数的功能：

+ `downloadFile(source, target, progress)` 从一个URL下载文件并保存到本地
+ `copyFile(source, target, progress)` 复制一个本地文件

然后再编写一个`download()`函数来判断`source`参数，并选择使用`downloadFile()`或者`copyFile()`来完成请求。

### 编写程序

在本项目中，所有的ES2015源程序均保存在`src`目录下，发布项目时会执行相应的命令将其编译并输出到`lib`目录，具体方法在 **「发布模块」** 小节中介绍。

实现`copyFile()`函数，新建文件`src/copy.js`：

```javascript
import fs from 'fs';

export default function copyFile(source, target, progress) {
  return new Promise((resolve, reject) => {

    fs.stat(source, (err, stats) => {
      if (err) return reject(err);

      let ss = fs.createReadStream(source);
      let ts = fs.createWriteStream(target);
      ss.on('error', reject);
      ts.on('error', reject);

      let copySize = 0;
      ss.on('data', data => {
        copySize += data.length;
        progress && progress(copySize, stats.size);
      });

      ss.on('end', () => resolve(target));

      ss.pipe(ts);
    });

  });
}
```

说明：

+ `import fs from 'fs'`为ES2015模块系统加载模块的方式，可理解为`var fs = require('fs')`，具体在下文「模块系统」一节中介绍。
+ 通过`fs.createReadStream(source)`和`fs.createWriteStream(target)`来创建读取文件流和写入文件流，并监听读取文件流的`data`事件获得当前进度信息。
+ `export default function copyFile() {}`将函数`copyFile()`作为模块输出，相当于`module.exports = function copyFile() {}`，具体在下文「模块系统」一节中介绍。
+ 函数执行后返回一个`Promise`对象，通过其`.then()`和`.catch()`来获取执行结果，关于Promise的详细介绍可阅读[阮一峰](http://www.ruanyifeng.com)所著的[「ECMAScript 6 入门 」](http://es6.ruanyifeng.com/)中[「 Promise对象」](http://es6.ruanyifeng.com/#docs/promise)一章。

为了测试该代码能否正常工作，可在文件末尾增加以下测试程序（在编写单元测试时将删除）：

```javascript
copyFile(__filename, '/tmp/copy.js', (size, total) => console.log(`进度${size}/${total}`))
  .then(filename => console.log(`已保存到${filename}`))
  .catch(err => console.log(`出错：${err}`));
```

以上程序的作用是将当前JavaScript文件复制到`/tmp/copy.js`，使用`babel-node`执行该文件将得到以下结果：

```bash
$ babel-node src/copy.js

进度749/749
已保存到/tmp/copy.js
```

实现`downloadFile()`函数，新建文件`src/download.js`：

```javascript
import fs from 'fs';
import request from 'request';

export default function downloadFile(url, target, progress) {
  return new Promise((resolve, reject) => {

    let s = fs.createWriteStream(target);
    s.on('error', reject);

    let totalSize = 0;
    let downloadSize = 0;
    let req = request
      .get({
        url: url,
        encoding: null
      })
      .on('response', res => {
        if (res.statusCode !== 200) {
          return reject(new Error('status #' + res.statusCode));
        }
        totalSize = Number(res.headers['content-length']) || null;

        res.on('data', data => {
          downloadSize += data.length;
          progress && progress(downloadSize, totalSize);
        });
        res.on('end', () => resolve(target));
      })
      .pipe(s);

  });
}
```

说明：

+ 程序使用`request`模块来下载URL的内容，使用时执行命令`$ npm i request --save`安装该模块。
+ 通过`request`模块的`pipe()`方法将收到的数据写入到`fs.createWriteStream(target)`创建的写入文件流中，`request`模块的详细使用方法可参考其文档：https://www.npmjs.com/package/request

为了测试该代码能否正常工作，可在文件末尾增加以下测试程序（在编写单元测试时将删除）：

```javascript
let url = 'http://dn-cnodestatic.qbox.me/public/images/cnodejs_light.svg';
downloadFile(url, '/tmp/avatar.jpg', (size, total) => console.log(`进度${size}/${total}`))
  .then(filename => console.log(`已保存到${filename}`))
  .catch(err => console.log(`出错：${err}`));
```

以上程序的作用是将URL为`http://dn-cnodestatic.qbox.me/public/images/cnodejs_light.svg`的文件复制到`/tmp/avatar.jpg`，使用`babel-node`执行该文件将得到以下结果：

```bash
$ babel-node src/download.js

进度5944/5944
已保存到/tmp/avatar.jpg
```

实现`download()`函数，新建文件`src/index.js`：

```javascript
import os from 'os';
import path from 'path';
import mkdirp from 'mkdirp';
import copyFile from './copy';
import downloadFile from './download';

export default function download(source, target, progress) {
  target = target || randomFilename(download.tmpDir);
  progress = progress || noop;
  return new Promise((resolve, reject) => {

    mkdirp(path.dirname(target), err => {
      if (err) return callback(err);

      resolve((isURL(source) ? downloadFile : copyFile)
        (source, target, progress));
    });

  });
}

let getTmpDir = os.tmpdir || os.tmpDir;

function randomString(size = 6, chars = 'abcdefghijklmnopqrstuvwxyz0123456789') {
  let max = chars.length + 1;
  let str = '';
  while (size > 0) {
    str += chars.charAt(Math.floor(Math.random() * max));
    size--;
  }
  return str;
}

function randomFilename(tmpDir = getTmpDir()) {
  return path.resolve(tmpDir, randomString(20));
}

function isURL (url) {
  if (url.substr(0, 7) === 'http://') return true;
  if (url.substr(0, 8) === 'https://') return true;
  return false;
}

export function noop() { }
```

说明：

+ `import copyFile from './copy'`用于载入模块，相当于`var copyFile = require('./copy')`。
+ `download(...args)`函数中的`...args`相当于`var args = Array.prototype.call(arguments);`。
+ 程序使用`mkdirp`模块来创建目标文件的上级目录，使用时执行命令`$ npm i mkdirp --save`安装该模块。
+ `getTmpDir()`函数用于取得当前系统的临时目录，通过`os.tmpDir()`获得。
+ `randomString(size)`函数用于生成指定长度的随机字符串。
+ `randomFilename(tmpDir)`用于生成临时文件名，默认存储在系统临时目录下，可通过`tmpDir`参数指定。
+ `isURL(url)`函数用于判断参数是否为一个URL。

为了验证程序是否正确，我们可以将上文的`src/copy.js`和`src/download.js`中的测试程序放到`src/index.js`文件的末尾并执行（需要将旧的程序程序删除），比如：

```javascript
download(__filename, '/tmp/copy.js', (size, total) => console.log(`进度${size}/${total}`))
  .then(filename => console.log(`已保存到${filename}`))
  .catch(err => console.log(`出错：${err}`));
```

正常情况下，其执行结果应该跟上文中的结果是一致的。

### 模块系统

Node.js使用的是CommonJS模块系统，模块的输出我们一般通过给`exports`对象设置属性来做：

```javascript
// 输出变量或函数
exports.x = 123;
exports.y = function () {
  console.log('hello');
};
```

可以通过以下方式来操作：

```javascript
var mod = require('./my_module');

console.log(mod.x);
mod.y();
```

也可以通过覆盖`module.exports`来输出一个函数或者其他数据类型：

```javascript
module.exports = function () {
  console.log('hello');
};
```

通过以下方式来操作：

```javascript
var fn = require('./my_module');

fn();
```

而在ES2015中，模块通过`export`语句来输出：

```javascript
// 普通输出，相当于 exports.x = y;
export const a = 123;
export var b = 456;
export function c() { }
export class d { }

// 默认输出，相当于 module.exports = z;
export default function y() { }
```

通过`import`语句来引入模块，不同的引入方式其含义是不一样的，比如：

```javascript
// 操作 export var x = y 方式的输出
import {a, b, c, d} from './my_module';
// 通过相应的变量名称 a, b, c, d 来操作

// 或者将所有输出指向一个对象
import * as mod from './my_module';
// 通过 mod.a, mod.b, mod.c, mod.d 来操作

// 操作 export default x 方式的输出
import y from './my_module';
```

对于非ES2015程序输出的模块，`import * as mod`和`import mod`其结果是一样的，比如：

```
import * as fs1 from 'fs';
import fs2 from 'fs';

// fs1.readFile() 和 fs2.readFile() 是一样的
```

为了更容易理解ES2015的模块系统原理，我们可以通过阅读编译后的JavaScript程序来了解。访问[babel的在线REPL](http://babeljs.io/repl/)或将程序保存到本地，并执行`babel file.js`来查看编译后的程序。

以下ES2015代码：

```javascript
export const a = 123;
export var b = 456;
export function c() { }
export class d { }

export default function y() { }
```

编译后结果如下：

```javascript
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.c = c;
exports["default"] = y;

function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

var a = 123;
exports.a = a;
var b = 456;
exports.b = b;

function c() {}

var d = function d() {
  _classCallCheck(this, d);
};

exports.d = d;

function y() {}
```

由上面的代码可以看出，`export var b = 456`这样的输出方式，实际上相当于`var b = exports.b = 456`，即直接设置`exports`对象的属性来完成。而`export default y`则是设置`exports`对象的`default`属性。

另外，还设置了`exports.__esModule = true`来标记这是一个ES2015输出的模块，在通过`import`来引入模块时会判断此属性来执行相应的规则，下文将详细介绍。

再看看以下的ES2015代码：

```javascript
import {a, b, c, d} from './my_module';
import * as mod from './my_module';
import y from './my_module';

a;
mod.a;
y;
```

其编译后的JavaScript代码如下：

```javascript
'use strict';

function _interopRequireDefault(obj) {
  return obj && obj.__esModule ? obj : {
    'default': obj
  };
}

function _interopRequireWildcard(obj) {
  if (obj && obj.__esModule) {
    return obj;
  } else {
    var newObj = {};
    if (obj != null) {
      for (var key in obj) {
        if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key];
      }
    }
    newObj['default'] = obj;
    return newObj;
  }
}

var _my_module = require('./my_module');

var mod = _interopRequireWildcard(_my_module);

var _my_module2 = _interopRequireDefault(_my_module);

_my_module.a;
mod.a;
_my_module2['default'];
```

首先，`a`是通过`import {a} from './my_module'`来引入的，编译后的代码中访问`a`使用的是`_my_module.a`，而`_my_module = require('./my_module')`，所以其对应的是`export var a = 123`这样的输出。

`mod`是通过`import * as mod from './my_module'`来引入的，其编译后的代码为`_interopRequireWildcard(require('./my_module'))`。在`_interopRequireWildcard()`函数中，如果载入的模块是由ES2015输出的，那么不做任何处理，否则会生成一个输入模块的拷贝，并且设置其`default`属性为自身。

`y`是通过`import y from './my_module'`来引入的，对`y`的访问被编译成了`_my_module2['default']`，所以`y`实际上是`export default`的输出。而`_my_module2 = _interopRequireDefault(require('./my_module'))`，函数`_interopRequireDefault()`对载入的非ES2015模块做了处理，会返回一个`default`属性指向该模块的新对象。

当然模块系统的还有更复杂的语法规则，详细说明可参考：[阮一峰](http://www.ruanyifeng.com)所著的[「ECMAScript 6 入门」](http://es6.ruanyifeng.com/)中[「Module」](http://es6.ruanyifeng.com/#docs/module)一章。

### 封装模块

上文例子中的`download()`函数所在的文件`src/index.js`中用到`randomFilename()`和`isURL()`这两个函数，为了使得代码结构更清晰，我们尝试把这些工具函数转移到`src/utils.js`中。

新建文件`src/utils.js`：

```javascript
import path from 'path';
import os from 'os';

let getTmpDir = os.tmpdir || os.tmpDir;

function randomString(size = 6, chars = 'abcdefghijklmnopqrstuvwxyz0123456789') {
  let max = chars.length + 1;
  let str = '';
  while (size > 0) {
    str += chars.charAt(Math.floor(Math.random() * max));
    size--;
  }
  return str;
}

export function randomFilename(tmpDir = getTmpDir()) {
  return path.resolve(tmpDir, randomString(20));
}

export function isURL (url) {
  if (url.substr(0, 7) === 'http://') return true;
  if (url.substr(0, 8) === 'https://') return true;
  return false;
}

export function noop() { }
```

说明：`getTmpDir()`和`randomString()`仅在函数`randomFilename()`函数中用到，所以不需要使用`export`输出。

修改文件`src/index.js`，将相应的代码删掉，并在文件首部`import`语句后面增加以下代码：

```javascript
import {randomFilename, isURL, noop} from './utils';
```
