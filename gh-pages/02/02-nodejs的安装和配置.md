
<h1 style="font-size: 40px;text-align:center;color: #007cdc;">
    Nodejs环境配置（以Windows为例）
</h1>

## 1.下载安装
访问[nodejs](https://nodejs.org/)下载并安装，一路next即可。

## 2.配置环境变量

```
PATH = C:\Program Files\nodejs;
```
## 3.配置npm
- 在nodejs的安装目录下新增node_global和node_cache目录，并使用npm配置：

```
$ npm config set prefix "C:\Program Files\nodejs\node_global"
$ npm config set cache "C:\Program Files\nodejs\node_cache"
```

- 再次配置环境变量

```
PATH = C:\Program Files\nodejs\node_global;
NODE_PATH = C:\Program Files\nodejs\node_global\node_modules;
```

这个时候，执行`npm install xxx -g`的时候下载的包都会放到`C:\Program Files\nodejs\node_global`下面。

## 4.npm的使用介绍

请直接前往：[NPM的使用方法](/idoc/html/技术分享/NPM的使用方法.html)
