# Nodejs中的对象和核心API

## node中常用的全局对象

> 浏览器中运行的js可以访问全局对象window，同样的，在node中运行的js可以访问全局对象global，下面一起了解下在nodejs中都有哪些非常有用的全局对象。


`global`是全局命名空间对象。

这里需要说明的是，在浏览器中，顶级作用域就是全局作用域。这就是说，在浏览器中，如果当前是在全局作用域内，var something将会声明一个全局变量。在Node中则不同。顶级作用域并非全局作用域，在Node模块里的var something只属于那个模块。

### Console对象

console 用于提供控制台标准输出，它是由 Internet Explorer 的 JScript 引擎提供的调试工具，后来逐渐成为浏览器的事实标准。 Node.js 沿用了这个标准，提供与习惯行为一致的 console 对象，用于向标准输出流（stdout）或标准错误流（stderr）输出字符。

console 方法 以下为 console 对象的方法:

- console.log([data][, ...]) 向标准输出流打印字符并以换行符结束。该方法接收若干 个参数，如果只有一个参数，则输出这个参数的字符串形式。如果有多个参数，则 以类似于C 语言 printf() 命令的格式输出。
- console.info([data][, ...]) P该命令的作用是返回信息性消息，这个命令与console.log差别并不大，除了在chrome中只会输出文字外，其余的会显示一个蓝色的惊叹号。
- console.error([data][, ...]) 输出错误消息的。控制台在出现错误时会显示是红色的叉子。
- console.warn([data][, ...]) 输出警告消息。控制台出现有黄色的惊叹号。
- console.dir(obj[, options]) 用来对一个对象进行检查（inspect），并以易于阅读和打印的格式显示。
- console.time(label) 输出时间，表示计时开始。
- console.timeEnd(label) 结束时间，表示计时结束。
- console.trace(message[, ...]) 当前执行的代码在堆栈中的调用路径，这个测试函数运行很有帮助，只要给想测试的函数里面加入 - console.trace 就行了。
- console.assert(value[, message][, ...]) 用于判断某个表达式或变量是否为真，接手两个参数，第一个参数是表达式，第二个参数是字符串。只有当第一个参数为false，才会输出第二个参数，否则不会有任何结果。
- console.log()：向标准输出流打印字符并以换行符结束。 console.log 接受若干 个参数，如果只有一个参数，则输出这个参数的字符串形式。如果有多个参数，则 以类似于C 语言 printf() 命令的格式输出。 第一个参数是一个字符串，如果没有 参数，只打印一个换行。

```
console.log('Hello world');
console.log('byvoid%diovyb');
console.log('byvoid%diovyb', 1991);
console.error()：与console.log() 用法相同，只是向标准错误流输出。 console.trace()：向标准错误流输出当前的调用栈。
```
### Buffer对象

Buffer对象Node原生提供的全局对象，用来处理二进制数据的一个接口。JavaScript比较擅长处理Unicode数据，对于处理二进制格式的数据（比如TCP数据流），就不太擅长。Buffer对象就是为了解决这个问题而提供的。该对象也是一个构造函数，它的实例代表了V8引擎分配的一段内存，基本上是一个数组，成员都为整数值。

> API说明

```javascript
{ [Function: Buffer]
  poolSize: 8192,
  isBuffer: [Function: isBuffer],
  compare: [Function: compare],
  isEncoding: [Function],
  concat: [Function],
  byteLength: [Function: byteLength] }
```

暂时存放的一块内存，处理二进制类型文件
创建buffer有三种办法：
- `new Buffer(size)`指定长度，然后fill填充内容
- `new Buffer(['sss', 'xxx'])`传入一个数组
- `new Buffer('郭永峰')`传入一个字符串

### 几个重要的模块内部的局部变量

模块内部的局部变量，指向的对象根据模块不同而不同，但是所有模块都适用，可以看作是伪全局变量， 主要为__filename,__dirname,module, module.exports, exports等。

**__filename**
注意此属性并不是全局对象的属性，而只是node在我们注入模块的参数，可以在模块内直接使用. _filename 表示当前正在执行的脚本的文件名。它将输出文件所在位置的绝对路径

 // 输出全局变量 __filename 的值
 console.log( __filename );
**__dirname**
注意此属性并不是全局对象的属性，而只是node为我们注入模块的参数，可以在模块内直接使用. __dirname 表示当前执行脚本所在的目录。

// 输出全局变量 __dirname 的值
console.log( __dirname );
**module**
代表当前模块本身

**exports**
模块的导出对象


### path对象

path.join方法用于连接路径。该方法的主要用途在于，会正确使用当前系统的路径分隔符，Unix系统是”/“，Windows系统是”\“。

API接口有：`normalize` `join` `resolve` `parse` `dirname` `basename` `

**path.resolve()**：一个重要的方法

path.resolve方法用于将相对路径转为绝对路径。

它可以接受多个参数，依次表示所要进入的路径，直到将最后一个参数转为绝对路径。如果根据参数无法得到绝对路径，就以当前所在路径作为基准。除了根目录，该方法的返回值都不带尾部的斜杠。

```
// 格式
path.resolve([from ...], to)

// 实例
path.resolve('foo/bar', '/tmp/file/', '..', 'a/../subfile')
```
上面代码的实例，执行效果类似下面的命令。

bash

$ cd foo/bar
$ cd /tmp/file/
$ cd ..
$ cd a/../subfile
$ pwd

```
path.resolve('/foo/bar', './baz')
// '/foo/bar/baz'

path.resolve('/foo/bar', '/tmp/file/')
// '/tmp/file'

path.resolve('wwwroot', 'static_files/png/', '../gif/image.gif')
// 如果当前目录是/home/myself/node，返回
// /home/myself/node/wwwroot/static_files/gif/image.gif
该方法忽略非字符串的参数。
```

### stream流对象

Stream把较大的数据，拆成很小的部分。只要命令部署了Stream接口，就可以把一个流的输出接到另一个流的输入。Node引入了这个概念，通过Stream为异步读写数据提供的统一接口。无论是硬盘数据、网络数据，还是内存数据，都可以采用这个接口读写。

后面接触的文件系统fs就是基于stream来实现，比较常用的构建工具gulp也是基于流来工作的。

一个典型的写文件操作：

```
var http = require('http');
var fs = require('fs');

var server = http.createServer(function (req, res) {
  fs.readFile(__dirname + '/data.txt', function (err, data) {
    res.end(data);
  });
});

server.listen(8000);
```

Stream接口分成三类。

- 可读数据流接口，用于读取数据。

```
var Readable = require('stream').Readable;

var rs = new Readable; rs.push('beep '); rs.push('boop\n'); rs.push(null);

rs.pipe(process.stdout);
```


- 可写数据流接口，用于写入数据。

```
var fs = require('fs'); var readableStream = fs.createReadStream('file1.txt'); var writableStream = fs.createWriteStream('file2.txt');

readableStream.setEncoding('utf8');

readableStream.on('data', function(chunk) { writableStream.write(chunk); });
```

- 双向数据流接口，用于读取和写入数据，比如Node的tcp、sockets、zlib、crypto都部署了这个接口。

### process

API接口：argv pid kill stdout stderr strin console nextTick 等

process 是一个全局变量，即 global 对象的属性。 它用于描述当前Node.js 进程状态的对象，提供了一个与操作系统的简单接口。通常在你写本地命令行程序的时候，少不了要 和它打交道。下面将会介绍 process 对象的一些最常用的成员方法。

**process.arg**
是命令行参数数组，第一个元素是node.exe可执行文件的路径,第二个参数是执行的脚本文件所有路径，从第三个元素开始每个参数是一个运行时传入的参数

console.log(process.argv);
以将上代码保存为argv.js,然后运行

```
E:\nodejs\test>node argv.js test input
```

得到结果

```
[ 'C:\\Program Files\\nodejs\\node.exe',
  'E:\\testjus\\argv.js',
  'test',
  'input' ]
```

**process.stdout**
标准输出流，通常我们使用的console.log往标准输出打印字符，其实调用的就是process.stdout.write()函数

**process.stdin**
标准输入流，初始时它是暂停的，要想从标准输入读取数据，必须恢复流，并手动编写流的事件响应函数。

```
process.stdin.resume();

process.stdin.on('data',function(data){
  process.stdout.write('从控制台读入用户输入的字符'+data.toString());
});
```

## 学习node中的核心模块

### Fs模块

fs是filesystem的缩写，该模块提供本地文件的读写能力，基本上是POSIX文件操作命令的简单包装。但是，这个模块几乎对所有操作提供异步和同步两种操作方式，供开发者选择。

readFileSync()
readFileSync方法用于同步读取文件，返回一个字符串。

```
var text = fs.readFileSync(fileName, "utf8");

// 将文件按行拆成数组
text.split(/\r?\n/).forEach(function (line) {
  // ...
});
```

writeFileSync()
writeFileSync方法用于同步写入文件。

```
fs.writeFileSync(fileName, str, 'utf8');
```

mkdir()，writeFile()，readfile()
mkdir方法用于新建目录。

```
var fs = require('fs');

fs.mkdir('./helloDir',0777, function (err) {
  if (err) throw err;
});
```

mkdir接受三个参数，第一个是目录名，第二个是权限值，第三个是回调函数。

writeFile方法用于写入文件。

```
var fs = require('fs');

fs.writeFile('./helloDir/message.txt', 'Hello Node', function (err) {
  if (err) throw err;
  console.log('文件写入成功');
});
```

readfile方法用于读取文件内容。

```
var fs = require('fs');

fs.readFile('./helloDir/message.txt','UTF-8' ,function (err, data) {
  if (err) throw err;
  console.log(data);
});
```

上面代码使用readFile方法读取文件。readFile方法的第一个参数是文件名，第二个参数是文件编码，第三个参数是回调函数。可用的文件编码包括“ascii”、“utf8”和“base64”。如果没有指定文件编码，返回的是原始的缓存二进制数据，这时需要调用buffer对象的toString方法，将其转为字符串。

```
var fs = require('fs');
fs.readFile('example_log.txt', function (err, logData) {
  if (err) throw err;
  var text = logData.toString();
});
```

readFile方法是异步操作，所以必须小心，不要同时发起多个readFile请求。

```
for(var i = 1; i <= 1000; i++) {
  fs.readFile('./'+i+'.txt', function() {
     // do something with the file
  });
}
```

上面代码会同时发起1000个readFile异步请求，很快就会耗尽系统资源。

### Http模块

Http模块主要用于搭建HTTP服务。使用Node.js搭建HTTP服务器非常简单。

* 处理GET请求

```
var http = require("http");

http.createServer(function(req, res) {

// 主页
if (req.url == "/") {
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end("Welcome to the homepage!");
}

// About页面
else if (req.url == "/about") {
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end("Welcome to the about page!");
}

// 404错误
else {
  res.writeHead(404, { "Content-Type": "text/plain" });
  res.end("404 error! File not found.");
}
}).listen(8080, "localhost");
```

上面代码第一行var http = require("http")，表示加载http模块。然后，调用http模块的createServer方法，创造一个服务器实例，将它赋给变量http。

ceateServer方法接受一个函数作为参数，该函数的request参数是一个对象，表示客户端的HTTP请求；response参数也是一个对象，表示服务器端的HTTP回应。response.writeHead方法表示，服务器端回应一个HTTP头信息；response.end方法表示，服务器端回应的具体内容，以及回应完成后关闭本次对话。最后的listen(8080)表示启动服务器实例，监听本机的8080端口。

将上面这几行代码保存成文件app.js，然后用node调用这个文件，服务器就开始运行了。

* 处理POST请求

当客户端采用POST方法发送数据时，服务器端可以对data和end两个事件，设立监听函数。

```
var http = require('http');

http.createServer(function (req, res) { var content = "";

req.on('data', function (chunk) {
  content += chunk;
});

req.on('end', function () {
  res.writeHead(200, {"Content-Type": "text/plain"});
  res.write("You've sent: " + content);
  res.end();
});
}).listen(8080);
```

**模块属性**

（1）HTTP请求的属性

```
headers：HTTP请求的头信息。
url：请求的路径。
```
**模块方法**

（1）http模块的方法

```
createServer(callback)：创造服务器实例。
```

（2）服务器实例的方法

```
listen(port)：启动服务器监听指定端口。
```

（3）HTTP回应的方法

```
setHeader(key, value)：指定HTTP头信息。
write(str)：指定HTTP回应的内容。
end()：发送HTTP回应。
```

### Events模块和异步编程

Events模块是node.js对“发布/订阅”模式（publish/subscribe）的部署。一个对象通过这个模块，向另一个对象传递消息。该模块通过EventEmitter属性，提供了一个构造函数。该构造函数的实例具有on方法，可以用来监听指定事件，并触发回调函数。任意对象都可以发布指定事件，被EventEmitter实例的on方法监听到。

下面是一个实例，先建立一个消息中心，然后通过on方法，为各种事件指定回调函数，从而将程序转为事件驱动型，各个模块之间通过事件联系。

```
var EventEmitter = require("events").EventEmitter;

var ee = new EventEmitter();
ee.on("someEvent", function () {
  console.log("event has occured");
});

ee.emit("someEvent");
```

Events模块的作用，还在于其他模块可以部署EventEmitter接口，从而也能够订阅和发布消息。

```
var EventEmitter = require('events').EventEmitter;

function Dog(name) {
  this.name = name;
}

Dog.prototype.__proto__ = EventEmitter.prototype;
// 另一种写法
// Dog.prototype = Object.create(EventEmitter.prototype);

var simon = new Dog('simon');

simon.on('bark', function(){
  console.log(this.name + ' barked');
});

setInterval(function(){
  simon.emit('bark');
}, 500);

```

上面代码新建了一个构造函数Dog，然后让其继承EventEmitter，因此Dog就拥有了EventEmitter的接口。最后，为Dog的实例指定bark事件的监听函数，再使用EventEmitter的emit方法，触发bark事件。
