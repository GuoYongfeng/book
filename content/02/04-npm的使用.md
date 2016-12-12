# NPM 使用介绍

NPM是随同NodeJS一起安装的包管理工具，能解决NodeJS代码部署上的很多问题，常见的使用场景有以下几种：

- 允许用户从NPM服务器下载别人编写的第三方包到本地使用。
- 允许用户从NPM服务器下载并安装别人编写的命令行程序到本地使用。
- 允许用户将自己编写的包或命令行程序上传到NPM服务器供别人使用。

由于新版的nodejs已经集成了npm，所以之前npm也一并安装好了。同样可以通过输入 "npm -v" 来测试是否成功安装。命令如下，出现版本提示表示安装成功:

```
$ npm -v
```

如果你安装的是旧版本的 npm，可以很容易得通过 npm 命令来升级，命令如下：

```
$ sudo npm install npm -g
```

如果是 Window 系统使用以下命令即可：
```

npm install npm -g
```

## 1.模块初始化

创建模块，package.json 文件是必不可少的。我们可以使用 NPM 生成 package.json 文件，生成的文件包含了基本的结果。

```
$ npm init
```

以上的信息，你需要根据你自己的情况输入。在最后输入 "yes" 后会生成 package.json 文件。

## 2.使用 package.json

package.json 位于模块的目录下，用于定义包的属性。接下来让我们来看下 express 包的 package.json 文件，位于 node_modules/express/package.json 内容：

`Package.json` 属性说明

- name - 包名。
- version - 包的版本号。
- description - 包的描述。
- homepage - 包的官网 url 。
- author - 包的作者姓名。
- contributors - 包的其他贡献者姓名。
- dependencies - 依赖包列表。如果依赖包没有安装，npm 会自动将依赖包安装在 node_module 目录下。
- repository - 包代码存放的地方的类型，可以是 git 或 svn，git 可在 Github 上。
- main - main 字段是一个模块ID，它是一个指向你程序的主要项目。就是说，如果你包的名字叫 express，然后用户安装它，然后require("express")。
- keywords - 关键字


## 3.使用 npm 命令安装模块

先设置一下镜像源地址和loglevel

```
$ npm config set registry http://registry.npm.taobao.org
$ npm config set loglevel=http
```

npm 安装 Node.js 模块语法格式如下：

```
$ npm install <Module Name>
```

以下实例，我们使用 npm 命令安装常用的 Node.js web框架模块 express:

```
$ npm install express
```

安装好之后，express 包就放在了工程目录下的 node_modules 目录中，因此在代码中只需要通过 require('express') 的方式就好，无需指定第三方包路径。
```
var express = require('express');
```

### 3.1 本地安装

1. 将安装包放在 ./node_modules 下（运行 npm 命令时所在的目录），如果没有 node_modules 目录，会在当前执行 npm 命令的目录下生成 node_modules 目录。
2. 可以通过 require() 来引入本地安装的包。

具体安装执行：
```
npm install express --save      # 版本名和版本号记录在dependencies字段
npm install express --save-dev  # 版本名和版本号记录在devDependencies字段
```


### 3.2 全局安装

1. 将安装包放在 /usr/local 下。
2. 可以直接在命令行里使用。
3. 不能通过 require() 来引入本地安装的包。

接下来我们使用全局方式安装 gulp

```
# 全局安装
$ npm install gulp -g
```
安装过程输出如下内容，第一行输出了模块的版本号及安装位置。

你可以使用以下命令来查看所有全局安装的模块：
```
$ npm ls -g
```

## 4.卸载模块
我们可以使用以下命令来卸载 Node.js 模块。

```
$ npm uninstall express
```

卸载后，你可以到 /node_modules/ 目录下查看包是否还存在，或者使用以下命令查看：

```
$ npm ls
```

## 5.更新模块
我们可以使用以下命令更新模块：

```
$ npm update express
```

## 6.搜索模块
使用以下来搜索模块：

```
$ npm search express
```


## 7.发布模块

接下来我们可以使用以下命令在 npm 资源库中注册用户（使用邮箱注册）：

```
$ npm adduser
Username: mcmohd
Password:
Email: (this IS public) 296512521@qq.com
```

接下来我们就用以下命令来发布模块：

```
$ npm publish
```

如果你以上的步骤都操作正确，你就可以跟其他模块一样使用 npm 来安装。

## 8.版本号

使用NPM下载和发布代码时都会接触到版本号。NPM使用语义版本号来管理代码，这里简单介绍一下。
语义版本号分为X.Y.Z三位，分别代表主版本号、次版本号和补丁版本号。当代码变更时，版本号按以下原则更新。
- 如果只是修复bug，需要更新Z位。
- 如果是新增了功能，但是向下兼容，需要更新Y位。
- 如果有大变动，向下不兼容，需要更新X位。

版本号有了这个保证后，在申明第三方包依赖时，除了可依赖于一个固定版本号外，还可依赖于某个范围的版本号。例如"argv": "0.0.x"表示依赖于0.0.x系列的最新版argv。
NPM支持的所有版本号范围指定方式可以查看官方文档。

## 9.NPM 常用命令

除了本章介绍的部分外，NPM还提供了很多功能，package.json里也有很多其它有用的字段。

除了可以在npmjs.org/doc/查看官方文档外，这里再介绍一些NPM常用命令。

- NPM提供了很多命令，例如install和publish，使用npm help可查看所有命令。
- 使用npm help <command>可查看某条命令的详细帮助，例如npm help install。
- 在package.json所在目录下使用npm install . -g可先在本地安装当前命令行程序，可用于发布前的本地测试。
- 使用npm update <package>可以把当前目录下node_modules子目录里边的对应模块更新至最新版本。
- 使用npm update <package> -g可以把全局安装的对应命令行程序更新至最新版。
- 使用npm cache clear可以清空NPM本地缓存，用于对付使用相同版本号发布新版本代码的人。
- 使用npm unpublish <package>@<version>可以撤销发布自己发布过的某个版本代码。
