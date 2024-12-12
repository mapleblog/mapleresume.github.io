---
title: Hexoの部署
date: 2024-12-03 11:05:44
categories:
- Platform
- Hexoの部署
tags:
---

# 1. 事前准备
1.1 **GitHub**（必须，你需要注册一个GitHub帐号）
1.2 **Cloudflare** （非必须，你需要注册一个Cloudflare帐号，这样你就可以将博客部署在CF的CDN里加速，但是你也可以直接使用GitHub.io分配的域名）
1.3 **域名** （非必须，你也可以使用免费域名，或者GitHub.io或Pages.dev分配的域名也可以）
<br>

# 2. 软件支持
2.1 **Node.js** （**必须**） [Official link](https://nodejs.org/en)
- 打开Node官网，下载和自己系统相配的Node的安装程序，否则会出现安装问题。
- 下载后安装，安装的目录可以使用默认目录 **`C:/Program Files/nodejs/`**
- 安装完成后，检查是否安装成功。在键盘按下 **`Win + R`** 键，输入 **`CMD`** ，然后回车，打开CMD窗口，执行 **`node -v`** 命令，看到版本信息，则说明安装成功。  
![成功安装](./images/nodejs.jpg)
- 修改npm源。npm下载各种模块。（用于在中国地区, 因为下载速度较慢）
```shell
npm config set registry https://mirrors.huaweicloud.com/repository/npm/
```

<br>

2.2 **Git** （**必须**） [Official link](https://git-scm.com/downloads)
- 下载后傻瓜式安装Git即可，安装的目录最好使用默认目录 **C:/Program Files/Git**
- 点击电脑左下角开始即可看见Git CMD、Git Bash、Git GUI。
	- **Git CMD** 是windows 命令行的指令风格
	- **Git Bash** 是linux系统的指令风格（建议使用）
	- **Git GUI** 是图形化界面（新手学习不建议使用）  

<br>

2.3 **VSCode** （**非必须**，这是一款轻量型的代码编辑器，可以帮助你养成一个很好的编程习惯） [Official link](https://code.visualstudio.com/)

# 3. 配置 Git 密钥并连接至 Github
**3.1 查看git的全局配置**
```shell
git config -l  //查看所有配置
git config --system --list //查看系统配置
git config --global --list //查看用户（全局）配置
```
![GitBash](/images/git_bash.jpg)

<br>

**3.2 配置用户名和邮箱**
```shell
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱"
```
通过 `git config -l` 检查是否配置成功。（ ***确保看到user.name 和 user.email，没看到代表没有配置到*** ）
![git配置](/images/gitconfig.png)

<br>

**3.3 配置公钥连接Github**
1. 执行以下命令生成 ssh公钥，此公钥用于你的计算机连接Github
```shell
ssh-keygen -t rsa -C "你的github邮箱"
```
 提示 ***Enter file in which to save the key*** 直接 **一路回车** 即可，新手小白不推荐设置密钥
 ![生成ssh-key](images/gitkey.png)
之后打开C盘下用户文件夹下的.ssh的文件夹，会看到以下文件
	- `id_rsa` 私钥
	- `id_rsa.pub` 公钥
	![.shh路径](images/rsa.png)
	用记事本打开上述图片中的公钥id_rsa.pub，复制里面的内容，然后开始在github中配置ssh密钥。
	![](images/openrsa.png)

<br>

2. 将 **SSH KEY** 配置到 GitHub 
---  进入 **github** > 点击 **右上角头像**
![打开github设置](images/gitsetting.png)

<br>

---  选择 **settings** > 进入设置页选择
![创建sshkey](images/newssh.png)

<br>

---  左边栏选择 **SSH and GPG keys** > 点击 **New SSH Key**
![完成创建](images/donessh.png)

<br>

---  这里必须要有展示你刚创建的记录
![ssh记录](images/sshrecord.png)

<br>

3. 测试链接，输入以下命令
```shell
ssh -T git@github.com
```

	第一次连接会提示 `Are you sure you want to continue connecting (yes/no/[fingerprint])?` ，输入 **yes** 即可
	{暂无图片可展示，以后补上}

	出现连接到账户的信息，说明已经大功告成，至此完成了环境准备工作。
	{暂无图片可展示，以后补上}

**3.4 创建GitHub.io仓库**
- 点击右上角的 `+` 按钮，选择**New repository**，创建一个 `<用户名>.github.io` 的仓库。
- 仓库名字的格式必须为： `<用户名>.github.io` (注意：前缀必须为用户名，此为预览博客需要，后期可修改仓库名)
- 可见性必须选择 `Public` 方便第一次部署检查问题，点击 **Creat repository** 进行创建即可





