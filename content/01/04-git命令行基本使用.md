## 基本命令行使用


![enter image description here](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015120901.png)


## 工作流程

- 克隆 Git 资源作为工作目录（或者自己新建一个工作目录并初始化为Git仓库）。
- 在克隆的资源上添加或修改文件。
- 如果其他人修改了，你可以更新资源。
- 在提交前查看修改。
- 提交修改。
- 在修改完成后，如果发现错误，可以撤回提交并再次修改并提交。


## 工作区、暂存区和版本库的理解
你的本地仓库由 git 维护的三棵“树”组成。第一个是你的 工作目录，它持有实际文件；第二个是 缓存区（Index），它像个缓存区域，临时保存你的改动；最后是 HEAD，指向你最近一次提交后的结果。

<img src="../images/git/flow.png" />

## 基本操作

### git init

新建一个仓库

``` shell
$ mkdir demo && cd demo
$ git init
```
### git clone
如果已经有了仓库，就可以直接clone到本地

``` shell
$ git clone git@github.com:GuoYongfeng/webpack-dev-boilerplate.git
```

### git add
git add 命令可将该文件添加到缓存，如我们添加以下两个文件：

``` shell
$ touch README.md
$ git add README.md
```
还可以
```
$ git add -A
$ git add *
```

### git status

git status 可以查看当前版本库各个文件的状态
```
$ git status
```

### git commit
使用 git add 命令将想要快照的内容写入缓存区， 而执行 git commit 将缓存区内容添加到仓库中。

```
$ git commit -m '第一次版本提交'
```

### git reset
git reset HEAD 命令用于取消已缓存的内容。
```
$ git reset HEAD -- hello.php
```

如果粗暴一点
```
$ git reset --hard 版本号
```

### git rm
```
$ git rm README.md
```

### 配置alias别名

配置别名的好处是方便简写命令

```
$ git config --global alias.st status
$ git config --global alias.ci commit
$ git config --global alias.co checkout
$ git config --global alias.br branch
$ git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```



## 打tag标签

在软件发布时创建标签，是被推荐的。

使用如下命令获取版本号：
```
$ git log
```

可以执行如下命令以创建一个叫做 1.0.0 的标签：
```
$ git tag 1.0.0 1b2e1d63ff
```

1b2e1d63ff 是你想要标记的提交 ID 的前 10 位字符。

## 撤销修改和版本回退

假如你做错事（自然，这是不可能的），你可以使用如下命令替换掉本地改动：
```
$ git checkout -- <filename>
```

此命令会使用 HEAD 中的最新内容替换掉你的工作目录中的文件。已添加到缓存区的改动，以及新文件，都不受影响。

假如你想要丢弃你所有的本地改动与提交，可以到服务器上获取最新的版本并将你本地主分支指向到它：
```
# 获取的版本号可以使用git log拿到
$ git reset --hard 希望回退的版本号
```
