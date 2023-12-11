---
title: 最常用的Git命令汇总
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309120849258.png
categories:
  - Git
tags:
  - Git
abbrlink: 19040
date: 2022-10-07 08:58:32
---
# 常用 Git 命令清单

> 整理：[CS_GUIDER](https://wl2o2o.github.io/)，作者：阮一峰，原文链接：https://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

宝藏资源推荐✨✨✨：

推荐一个快速练习 Git 的宝藏网站——动图演示 Git 的命令逻辑。
[戳我查看👆](https://learngitbranching.js.org/)

---

我每天使用 Git ，但是很多命令记不住。

一般来说，日常使用只要记住下图6个命令，就可以了。但是熟练使用，恐怕要记住60～100个命令。

![img](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015120901.png)

下面是我整理的常用 Git 命令清单。几个专用名词的译名如下。

> - Workspace：工作区
> - Index / Stage：暂存区
> - Repository：仓库区（或本地仓库）
> - Remote：远程仓库

## 一、新建代码库

> ```bash
> # 在当前目录新建一个Git代码库
> $ git init
> 
> # 新建一个目录，将其初始化为Git代码库
> $ git init [project-name]
> 
> # 下载一个项目和它的整个代码历史
> $ git clone [url]
> ```

## 二、配置

Git的设置文件为`.gitconfig`，它可以在用户主目录下（全局配置），也可以在项目目录下（项目配置）。

> ```bash
> # 显示当前的Git配置
> $ git config --list
> 
> # 编辑Git配置文件
> $ git config -e [--global]
> 
> # 设置提交代码时的用户信息
> $ git config [--global] user.name "[name]"
> $ git config [--global] user.email "[email address]"
> 
> # usage: git config [<options>]
> Config file location
>     --global              use global config file
>     --system              use system config file
>     --local               use repository config file
>     --worktree            use per-worktree config file
>     -f, --file <file>     use given config file
>     --blob <blob-id>      read config from given blob object
> 
> Action
>     --get                 get value: name [value-pattern]
>     --get-all             get all values: key [value-pattern]
>     --get-regexp          get values for regexp: name-regex [value-pattern]
>     --get-urlmatch        get value specific for the URL: section[.var] URL
>     --replace-all         replace all matching variables: name value [value-pattern]
>     --add                 add a new variable: name value
>     --unset               remove a variable: name [value-pattern]
>     --unset-all           remove all matches: name [value-pattern]
>     --rename-section      rename section: old-name new-name
>     --remove-section      remove a section: name
>     -l, --list            list all
>     --fixed-value         use string equality when comparing values to 'value-pattern'
>     -e, --edit            open an editor
>     --get-color           find the color configured: slot [default]
>     --get-colorbool       find the color setting: slot [stdout-is-tty]
> 
> Type
>     -t, --type <>         value is given this type
>     --bool                value is "true" or "false"
>     --int                 value is decimal number
>     --bool-or-int         value is --bool or --int
>     --bool-or-str         value is --bool or string
>     --path                value is a path (file or directory name)
>     --expiry-date         value is an expiry date
> 
> Other
>     -z, --null            terminate values with NUL byte
>     --name-only           show variable names only
>     --includes            respect include directives on lookup
>     --show-origin         show origin of config (file, standard input, blob, command line)
>     --show-scope          show scope of config (worktree, local, global, system, command)
>     --default <value>     with --get, use default value when missing entry
> 
> 
> ```

## 三、增加/删除文件

> ```bash
> # 添加指定文件到暂存区
> $ git add [file1] [file2] ...
> 
> # 添加指定目录到暂存区，包括子目录
> $ git add [dir]
> 
> # 添加当前目录的所有文件到暂存区
> $ git add .
> 
> # 添加每个变化前，都会要求确认
> # 对于同一个文件的多处变化，可以实现分次提交
> $ git add -p
> 
> # 删除工作区文件，并且将这次删除放入暂存区
> $ git rm [file1] [file2] ...
> 
> # 停止追踪指定文件，但该文件会保留在工作区
> $ git rm --cached [file]
> 
> # 改名文件，并且将这个改名放入暂存区
> $ git mv [file-original] [file-renamed]
> ```

## 四、代码提交

> ```bash
> # 提交暂存区到仓库区
> $ git commit -m [message]
> 
> # 提交暂存区的指定文件到仓库区
> $ git commit [file1] [file2] ... -m [message]
> 
> # 提交工作区自上次commit之后的变化，直接到仓库区
> $ git commit -a
> 
> # 提交时显示所有diff信息
> $ git commit -v
> 
> # 使用一次新的commit，替代上一次提交
> # 如果代码没有任何新变化，则用来改写上一次commit的提交信息
> $ git commit --amend -m [message]
> 
> # 重做上一次commit，并包括指定文件的新变化
> $ git commit --amend [file1] [file2] ...
> ```

## 五、分支

> ````bash
> # 列出所有本地分支
> $ git branch
> 
> # 列出所有远程分支
> $ git branch -r
> 
> # 列出所有本地分支和远程分支
> $ git branch -a
> 
> # 新建一个分支，但依然停留在当前分支
> $ git branch [branch-name]
> 
> # 新建一个分支，并切换到该分支
> $ git checkout -b [branch]
> 
> # 新建一个分支，指向指定commit
> $ git branch [branch] [commit]
> 
> # 新建一个分支，与指定的远程分支建立追踪关系
> $ git branch --track [branch] [remote-branch]
> 
> # 切换到指定分支，并更新工作区
> $ git checkout [branch-name]
> 
> # 切换到上一个分支
> $ git checkout -
> 
> # 建立追踪关系，在现有分支与指定的远程分支之间
> $ git branch --set-upstream [branch] [remote-branch]
> $ 详细说明：
> `--set-upstream`是`git push`命令的一个选项，它用于在将本地分支推送到远程仓库时，同时设置本地分支与远程分支的关联关系。
> 
> 当您使用`git push`命令将本地分支推送到远程仓库时，Git会尝试将本地分支的更新推送到与之关联的远程分支。通常情况下，当您首次推送本地分支时，远程仓库可能还没有与之对应的远程分支。在这种情况下，如果您使用`--set-upstream`选项，Git会自动在远程仓库上创建一个与本地分支同名的分支，并将其与本地分支关联起来。
> 
> 所以，当您执行以下命令时：
> ```
> git push --set-upstream origin hexo
> ```
> 它的含义是将当前分支（假设是`hexo`）的更新推送到名为`origin`的远程仓库，并在远程仓库上创建一个名为`hexo`的分支，并将其与本地分支进行关联。
> 
> 通过使用`--set-upstream`选项，您可以方便地建立本地分支与远程分支之间的连接，使得后续的`git push`命令可以自动将本地分支的更新推送到正确的远程分支。
> 
> # 合并指定分支到当前分支
> $ git merge [branch]
> 
> # 选择一个commit，合并进当前分支
> $ git cherry-pick [commit]
> 
> # 删除分支
> $ git branch -d [branch-name]
> 
> # 删除远程分支
> $ git push origin --delete [branch-name]
> $ git branch -dr [remote/branch]
> ````

## 六、标签

> ```bash
> # 列出所有tag
> $ git tag
> 
> # 新建一个tag在当前commit
> $ git tag [tag]
> 
> # 新建一个tag在指定commit
> $ git tag [tag] [commit]
> 
> # 删除本地tag
> $ git tag -d [tag]
> 
> # 删除远程tag
> $ git push origin :refs/tags/[tagName]
> 
> # 查看tag信息
> $ git show [tag]
> 
> # 提交指定tag
> $ git push [remote] [tag]
> 
> # 提交所有tag
> $ git push [remote] --tags
> 
> # 新建一个分支，指向某个tag
> $ git checkout -b [branch] [tag]
> ```

## 七、查看信息

> ```bash
> # 显示有变更的文件
> $ git status
> 
> # 显示当前分支的版本历史
> $ git log
> 
> # 显示commit历史，以及每次commit发生变更的文件
> $ git log --stat
> 
> # 搜索提交历史，根据关键词
> $ git log -S [keyword]
> 
> # 显示某个commit之后的所有变动，每个commit占据一行
> $ git log [tag] HEAD --pretty=format:%s
> 
> # 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
> $ git log [tag] HEAD --grep feature
> 
> # 显示某个文件的版本历史，包括文件改名
> $ git log --follow [file]
> $ git whatchanged [file]
> 
> # 显示指定文件相关的每一次diff
> $ git log -p [file]
> 
> # 显示过去5次提交
> $ git log -5 --pretty --oneline
> 
> # 显示所有提交过的用户，按提交次数排序
> $ git shortlog -sn
> 
> # 显示指定文件是什么人在什么时间修改过
> $ git blame [file]
> 
> # 显示暂存区和工作区的差异
> $ git diff
> 
> # 显示暂存区和上一个commit的差异
> $ git diff --cached [file]
> 
> # 显示工作区与当前分支最新commit之间的差异
> $ git diff HEAD
> 
> # 显示两次提交之间的差异
> $ git diff [first-branch]...[second-branch]
> 
> # 显示今天你写了多少行代码
> $ git diff --shortstat "@{0 day ago}"
> 
> # 显示某次提交的元数据和内容变化
> $ git show [commit]
> 
> # 显示某次提交发生变化的文件
> $ git show --name-only [commit]
> 
> # 显示某次提交时，某个文件的内容
> $ git show [commit]:[filename]
> 
> # 显示当前分支的最近几次提交
> $ git reflog
> ```

## 八、远程同步

> ```bash
> # 下载远程仓库的所有变动
> $ git fetch [remote]
> 
> # 显示所有远程仓库
> $ git remote -v
> 
> # 显示某个远程仓库的信息
> $ git remote show [remote]
> 
> # 增加一个新的远程仓库，并命名
> $ git remote add [shortname] [url]
> 
> # 取回远程仓库的变化，并与本地分支合并
> $ git pull [remote] [branch]
> 
> # 上传本地指定分支到远程仓库
> $ git push [remote] [branch]
> 
> # 强行推送当前分支到远程仓库，即使有冲突
> $ git push [remote] --force
> 
> # 推送所有分支到远程仓库
> $ git push [remote] --all
> ```

## 九、撤销

> ```bash
> # 恢复暂存区的指定文件到工作区                                 误删文件，用于恢复add时的状态
> $ git checkout [file]
> 
> # 恢复某个commit的指定文件到暂存区和工作区
> $ git checkout [commit] [file]
> 
> # 恢复暂存区的所有文件到工作区
> $ git checkout .
> 
> # 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变      已暂存的内容不想提交，用于取消暂存de
> $ git reset [file]
> 
> # 重置暂存区与工作区，与上一次commit保持一致
> $ git reset --hard
> 
> # 如果想回滚的话，比如说回滚到上一个版本，可以执行以下两种命令：
> 
> $ git reset --hard HEAD^         上上个版本就是 git reset --hard HEAD^^，以此类推。
> 
> $ git reset --hard HEAD~100      如果回滚到前 100 个版本，用这个命令比上一个命令更方便。
> 
> # 假如回滚错了，想恢复，不记得版本号了，可以先执行此命令查看版本号：
> $ git reflog
> 
> # 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
> $ git reset [commit]
> 
> # 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
> $ git reset --hard [commit]
> 
> # 重置当前HEAD为指定commit，但保持暂存区和工作区不变
> $ git reset --keep [commit]
> 
> # 新建一个commit，用来撤销指定commit
> # 后者的所有变化都将被前者抵消，并且应用到当前分支
> $ git revert [commit]
> 
> # 暂时将未提交的变化移除，稍后再移入
> $ git stash
> $ git stash pop
> ```

## 十、其他

> ```bash
> # 生成一个可供发布的压缩包
> $ git archive
> ```
> 

## 说说一个比较常见的问题：如何合并冲突？
> 当我们在远仓直接更新内容时，下次如果是在本地准备提交上传，如果忘记拉取最新更新，
> 那么在push时会拒绝我们推送，所以我们需要在提交前进行拉取远仓的最新变更，
> 然后手动处理冲突，最后再提交

拉取远程仓库变更：在本地仓库中运行 git pull 命令，将远程仓库中的最新变更拉取到本地。

处理冲突（如果存在）：如果在远程仓库和本地仓库同时修改了相同的文件，可能会发生冲突。Git 会将冲突标记在文件中，你需要手动解决这些冲突。打开有冲突的文件，查找并解决冲突的部分。完成后保存文件。

添加和提交变更：在本地仓库中使用 git add 命令将修改后的文件标记为已暂存，然后使用 git commit 命令提交这些变更。确保你提供了有意义的提交消息，以便于他人理解你所做的更改。

推送到远程仓库：使用 git push 命令将本地仓库的变更推送到远程仓库。



## 公司多分支仓库是怎么协作开发的？

在Git中，每个人创建一个分支进行协作是一种常见的模式。在这种情况下，主分支通常被称为"main"，其他分支则用于个人或团队的工作。

如果你想将主分支（main）的最新代码拉取到你的分支（github-wl）上，可以按照以下步骤进行操作：

1. 首先，确保你已经在你的本地仓库中创建了一个名为"github-wl"的分支。你可以使用以下命令创建并切换到该分支：

```shell
git checkout -b github-wl
```

2. 接下来，你需要将主分支（main）的最新代码拉取到你的本地仓库。可以使用以下命令从远程仓库中拉取最新代码：

```shell
git fetch origin main
```

这将会获取主分支的最新更改，但不会自动合并到你的分支。

3. 如果你想将这些更改合并到你的分支上，可以使用以下命令进行合并：

```shell
git merge origin/main
```

这将把主分支的最新代码合并到你的当前分支（github-wl）上。

4. 如果在合并过程中出现冲突，你需要手动解决冲突。Git会在冲突的文件中标记出冲突的部分，你需要打开这些文件并手动编辑以解决冲突。
5. 一旦冲突解决完成，你可以使用以下命令将你的分支推送到远程仓库：

```shell
git push origin github-wl
```

这将把你的分支（github-wl）的更改推送到远程仓库。

通过以上步骤，你可以将主分支（main）的最新代码拉取到你的分支（github-wl）上，并在解决冲突后将更改推送到远程仓库。
