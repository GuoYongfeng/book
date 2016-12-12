

## Node.js安装和配置

### windows上安装

- 先去下载一下[git](http://git-scm.com/download/)的客户端，可以运行git bash，方便使用shell命令

`step1.` 进入[nodejs.org](https://nodejs.org/)下载

`step2.` 下载完成后，双击默认安装。安装程序会自动添加环境变量

`step3.` 检测nodejs是否安装成功。打开cmd命令行 输入 :

```
node - v
```

`step4.` 检查npm是否安装。由于新版的NodeJS已经集成了npm，所以之前npm也一并安装好了。同样可以使用cmd命令行进行确认。

```
npm -v
```

### mac上安装

- 升级系统
- 升级xcode
```
xcode-select -p
xcode-select --install
```
- 安装Homebrew
前提是python和ruby安装好
官网查看方法
- 安装
```
brew install node
```
- 检查
```
node -v
```

### linux上安装

- 先要扫平环境问题
也可以到官网查看
要求gcc 4.2+和g++ 4.2+以及python 2.6和gnu的版本要求
- 检查
```
cat /etc/redhat-release
rpm -q gcc rpm -q gcc-c++
yum -y install gcc gcc-c++ kernel-devel
```
ubuntu下可以apt-get
```
cd /usr/src
wget 链接
tar -xf node包名
cd node包
./config
make
sudo make install
```
- 检查安装是否成功
```
node -v
npm -v
```
### 版本说明

> 目前最新的都已经到`5.1.0 `，这是从0.12版本后，nodejs和iojs(由于部分开发者对管理模式的不满，便fork了nodejs后创建了io.js，采用独立的社区驱动模式运营这个开源项目，每周一个版本迭代)合并了，直接从4.0版本开始发展了，到如今已经是5.1版本。当然，还在持续更新迭代中。

**关于nodejs版本号的说明**

偶数位的版本是稳定版本，而一般奇数位的就是非稳定版本，这几乎是在业界大家都达成共识了。比如0.6.x就是稳定版本，而0.11.x就是新功能测试的非稳定版本

建议选择最新的稳定版本进行使用。由于版本较多，为了方便node版本管理，推荐几个工具：

- osx, linux系统下

推荐使用n和nvm进行node的多版本管理，n是node的一个模块，TJ大神开发的。

```
npm install -g n
n 5.0.0
```

- windows系统下

推荐使用nvmw进行node的多版本管理。

```
// 选择一个目录下载nvmw，比如放在C:\Program Files\nvmw
git clone https://github.com/hakobera/nvmw.git
// 配置环境变量，在path中增加C:\Program Files\nvmw
// 运行nvmw命令
nvmw ls
nvmw use v5.0.0
nvmw install v5.0.0
```

不过，这个比较坑，git bash下无法运行，而且，对新版node还不支持

## 配置环境变量

```
PATH = C:\Program Files\nodejs;
```
## 配置npm
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
