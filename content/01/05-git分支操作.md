
## git 分支操作

有人把 Git 的分支模型称为“必杀技特性”，而正是因为它，将 Git 从版本控制系统家族里区分出来。Git 有何特别之处呢？Git 的分支可谓是难以置信的轻量级，它的新建操作几乎可以在瞬间完成，并且在不同分支间切换起来也差不多一样快。和许多其他版本控制系统不同，Git 鼓励在工作流程中频繁使用分支与合并，哪怕一天之内进行许多次都没有关系。

理解分支的概念并熟练运用后，你才会意识到为什么 Git 是一个如此强大而独特的工具，并从此真正改变你的开发方式。

```
# 创建分支
git branch branch_name
# 本地切换到这个分支
git checkout branch_name
```

```
# 创建并且直接切换到这个新分支
git checkout -b branch_name
```

```
# 分支合并，比如将分支develop合并到master分支
git checkout master
git merge master develop
```

![enter image description here](http://image.beekka.com/blog/201207/bg2012070506.png)
