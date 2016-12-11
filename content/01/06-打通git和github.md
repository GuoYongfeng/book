
## remote 远程操作

在管理Git项目上，很多时候都是直接使用https url克隆到本地，当然也有有些人使用SSH url克隆到本地。这两种方式的主要区别在于：
- 使用https url克隆对初学者来说会比较方便，复制https url然后到git Bash里面直接用clone命令克隆到本地就好了，但是每次fetch和push代码都需要输入账号和密码，这也是https方式的麻烦之处。
- 而使用SSH url克隆却需要在克隆之前先配置和添加好SSH key，因此，如果你想要使用SSH url克隆的话，你必须是这个项目的拥有者。否则你是无法添加SSH key的，另外ssh默认是每次fetch和push代码都不需要输入账号和密码，如果你想要每次都输入账号密码才能进行fetch和push也可以另外进行设置。

公钥、私钥

### 解决问题

- git remote

```
# 查看remote
$ git remote -v
# 删除remote
$ git remote rm origin
# 添加remote
$ git remote add origin your_git_repo_path
```

- ssh keys

查看本地是否有`SSH Key`

```
cd ~/.ssh
ls
```

如果没有就生成一个

```
ssh-keygen -t rsa -C "guoyff@yonyou.com"
```

- 在github上，settings->ssh keys->add
