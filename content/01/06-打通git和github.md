
# 打通git和github

## 关于remote 远程操作

在管理Git项目上，很多时候都是直接使用https url克隆到本地，当然也有有些人使用SSH url克隆到本地。这两种方式的主要区别在于：
- 使用https url克隆对初学者来说会比较方便，复制https url然后到git Bash里面直接用clone命令克隆到本地就好了，但是每次fetch和push代码都需要输入账号和密码，这也是https方式的麻烦之处。
- 而使用SSH url克隆却需要在克隆之前先配置和添加好SSH key，因此，如果你想要使用SSH url克隆的话，你必须是这个项目的拥有者。否则你是无法添加SSH key的，另外ssh默认是每次fetch和push代码都不需要输入账号和密码，如果你想要每次都输入账号密码才能进行fetch和push也可以另外进行设置。

## push到服务器

把代码从本地push到服务器上，这意味着我们首先要有个服务器或是托管我们代码的第三方服务，公司有gitlab也可以直接push到那。

为了方便练习，更为了以后学习，强烈建议直接把代码push到github进行托管。

### 开通github账号，方便技术交流和信息获取

- 请访问：https://github.com
- 然后注册一个账号


### 设置public key


首先需要在本地生成key，并且把key配置在github上

```
$ ssh-keygen -t rsa -C "guoyff@yonyou.com"
```


复制ublic key
```
$ cat ~/ssh/id_rsa.pub
```

当然，你也可以直接使用nodepad++等编辑器打开这个文件，复制出来。
（如果你是windows用户，这个文件一般会在这里：C:\Users\Administrator\.ssh）

将获得的public key添加在github账户上：

> 右上角点击头像-> 点击settings-> 点击SSH KEYS-> 点击ADD SSH KEYS-> 将获取的public key粘贴于此

### 在github上新建一个仓库

<img src="../images/git/repo.png" />

## 推送到远程服务器

如果你还没有克隆现有仓库，并欲将你的仓库连接到某个远程服务器，你可以使用如下命令添加：

```
# 为这个仓库添加一个远程地址
$ git remote add origin 你的github上的仓库地址（比如： git@github.com:GuoYongfeng/webpack-dev-boilerplate.git）
```
如此你就能够将你的改动推送到所添加的服务器上去了。
<br>
执行如下命令以将这些改动提交到远端仓库：
```
# 将本地版本库的资源推送到远程服务器
$ git push origin -u master
```
可以把 master 换成你想要推送的任何分支。
