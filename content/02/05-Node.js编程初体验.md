
## node初体验

### nodejs的REPL交互环境
在浏览器中控制台，我们可以直接编写js代码进行运行

在你的CMD窗口，键入node后回车，即可进入node的repl环境运行js代码。

[更多关于REPL的简单说明戳这里](http://segmentfault.com/a/1190000002673137)

### 写个脚本

代码参见[git仓库](https://github.com/iUAP-FE/nodejs)。

### 起个web服务

```
//http.js

var http = require('http');

var app = http.createServer(function(req, res){
  res.writeHead(200, {"Content-Type": "text/plain"});
  res.end("Hello world");
});

app.listen(1337);

```

是的，就是这样神奇，短短几行代码，就创建了一个web服务，而且，请不要轻视它，这还是一个高性能的web服务器。
