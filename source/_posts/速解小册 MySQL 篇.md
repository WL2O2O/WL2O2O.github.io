---
title: 速解小册 MySQL篇
tags:
  - MySQL
categories:
  - 速解小册
date: 2025-09-15 18:11:12
---

# MySQL常遇到的问题

## msi启动报错：error code is 2503
![速解小册 MySQL 篇-2025-09-15-21-22-08](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-09-15-21-22-08.png)

解决方法：
如果报错安装包受损，官网重新下载安装包后重新使用下图方法启动msi。
![速解小册 MySQL 篇-2025-09-15-21-23-18](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-09-15-21-23-18.png)


## 压缩包安装MySQL Community Server，没有MySQL快捷方式
> 使用msi进行安装MySQL的时候会自己创建一个如图的快捷方式`MySQL x.x Command Line Client`，单击直接输入密码即可进入mysql的命令行，使用压缩包进行安装的话会没有快捷方式，可以通过手动创建来解决

<img src="https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-28-01-39-34.png" alt="速解小册 MySQL 篇-2025-03-28-01-39-34" style="zoom:50%;" />

解决方法如下图所示：

<img src="https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-28-01-56-40.png" alt="速解小册 MySQL 篇-2025-03-28-01-56-40" style="zoom: 33%;" />


## net start mysql 报错：net 不是内部或外部命令
原因：
    环境变量问题
解决方法：
    打开环境变量，在path路径下添加C:\Windows\System32即可

## MySQL5.6 版本，net start mysql 启动服务报错
```txt
MySQL 服务正在启动 ...
MySQL 服务无法启动。
  
系统出错。
  
发生系统错误 1067。
  
进程意外终止。
```

解决方法：
    1. 不要创建my.ini文件，直接在my-default.ini文件中新增以下配置：
         basedir = D:\mysql-5.6.10-winx64  （改为你自己的安装路径）
         datadir = D:\mysql-5.6.10-winx64\data（改为你自己的安装路径）
         port = 3306
    2. 移除mysql服务
         mysqld -remove
    3. 安装mysql服务
         mysqld.exe -install
    4. 启动mysql服务
         net start mysql

## 项目和idea连接MySQL报密码错误，可是命令行登录MySQL显示密码正确
如图所示：
![速解小册 MySQL 篇-2025-03-25-12-02-34](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-25-12-02-34.png)
![速解小册 MySQL 篇-2025-03-25-12-03-19](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-25-12-03-19.png)

原因之一：禅道MySQL服务和MySQL服务冲突
解决办法：
   方案一：服务列表中停止禅道服务
   方案二：在禅道的服务窗口中配置 3306 以外的端口号
       ![速解小册 MySQL 篇-2025-03-25-12-10-08](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-25-12-10-08.png)

## 项目和idea连接MySQL报文件名、目录名或卷标语法不正确
如图所示：
![速解小册 MySQL 篇-2025-03-25-12-12-45](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-25-12-12-45.png)
解决办法：
   如上图中用户名后面出现了两个问号，足以说明是用户名乱码导致，所以需要更改用户文件夹下面的用户名文件夹名字，修改步骤如下：
   1. 打开系统设置面板，以Windows11为例，在账户中的其他用户中添加一个管理员账户，例如Administrator（新增一个管理员账户是为了通过这个有管理权限的账户去更改原来的用户名，更改成功之后即可删掉Administrator用户）；
   2. 打开控制面板，找到“控制面板\用户帐户\用户帐户”，然后将刚才新增的账户Administrator的账户类型改为管理员用户；
   3. 重启电脑，以新用户Administrator进行登录；
   4. 打开文件资源管理器，直接修改“C:\Users\”路径下的用户名称，例如"大帅哥" -> "handsome"，如果显示有文件正在使用中，那么自行百度解决后再进行下一步。切记切记切记！
   4. 打开注册表，在如下路径中找到需要修改的用户名：
      HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\<要修改的用户对应的sid>\
      ![速解小册 MySQL 篇-2025-03-25-12-24-38](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-25-12-24-38.png)
      找到如图中自己的用户名所在的ProfileImagePath，右键进行更改为想要修改的英文用户名（不含表情等特殊符号）
   5. 更改成功之后注销Administrator用户的登录，然后以新改的英文用户名登录
   6. 修改环境变量，因为环境变量中可能包含之前用户名的环境变量，所以需要将旧用户名与新用户名进行替换
   7. [可选]为了防止快捷方式打不开，创建一个软连接，可以防止一切路径问题。
   ```bash
   mklink /d "C:\Users\大帅哥" "C:\Users\handsome"
   ```
   8. [强迫症可选]下载Registry Workshop注册表管理程序，使用它来批量替换包含旧用户名的注册表

## mysqld: [ERROR] Found option without preceding group in config file D:\MySQL\MySQL Server 8.0\my.ini at line 1.

原因：my.ini 文件的编码问题
解决办法：
   方案一：文件另存为，更改文件编码为ANSI
   方案二：更改文件扩展名为.nasi

## mysql 服务启动后停止，某些服务在未由其他服务或程序使用时将自己停止 || 服务无法启动，没有报告任何问题

<img src="https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-11-01-11-05.png" alt="速解小册 MySQL 篇-2025-03-11-01-11-05" style="zoom:50%;" />

解决方法：首先data文件夹下的xxx.err文件，看文件末尾的最新日志
```bash
# 例如
2025-03-10T12:28:44.735297Z 0 [Warning] [MY-010918] [Server] 'default_authentication_plugin' is deprecated and will be removed in a future release. Please use authentication_policy instead.
2025-03-10T12:28:44.735332Z 0 [System] [MY-010116] [Server] D:\mysql\mysql-8.0.31-winx64\bin\mysqld.exe (mysqld 8.0.31) starting as process 2844
2025-03-10T12:28:44.754456Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-03-10T12:28:44.938273Z 1 [ERROR] [MY-012526] [InnoDB] Upgrade is not supported after a crash or shutdown with innodb_fast_shutdown = 2. This redo log was created with MySQL 5.7.26, and it appears logically non empty. Please follow the instructions at http://dev.mysql.com/doc/refman/8.0/en/upgrading.html
2025-03-10T12:28:44.939635Z 1 [ERROR] [MY-012930] [InnoDB] Plugin initialization aborted with error Generic error.
2025-03-10T12:28:44.976461Z 1 [ERROR] [MY-010334] [Server] Failed to initialize DD Storage Engine
2025-03-10T12:28:44.977669Z 0 [ERROR] [MY-010020] [Server] Data Dictionary initialization failed.
2025-03-10T12:28:44.978318Z 0 [ERROR] [MY-010119] [Server] Aborting
2025-03-10T12:28:44.979103Z 0 [System] [MY-010910] [Server] D:\mysql\mysql-8.0.31-winx64\bin\mysqld.exe: Shutdown complete (mysqld 8.0.31)  MySQL Community Server - GPL.

# 上述报错需要删除 data 文件夹下的`ib_logfile0`和`ib_logfile1`即可
```

## 找不到VCRUNTIME140_1.dll

![速解小册 MySQL 篇-2025-03-10-21-54-42](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/速解小册 MySQL 篇-2025-03-10-21-54-42.png)

解决方法：下载官方驱动

https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170#visual-studio-2015-2017-2019-and-2022

### SQLYog 连接本地 mysql 实例报插件错误（错误号码：2058 Plugin caching_sha2_password_authentication could net be loaded）
``` shell 
### 解决方案
方案1. mysql容器启动时 添加配置 --mysql-native-password=ON
方案2. my.cnf中 mysqld下添加一行 mysql-native-password=ON
```
## msi程序一直卡在start server的步骤 |　压缩包安装启动不了服务
```shell
### 报错信息：
本地计算机上的MySQL80服务启动后停止。某些服务在未由其他服务或程序使用时将自动停止。

### 解决方案：
设置 > 主页 > 重命名电脑名字为英文

### 重启电脑后
会发现 MySQL 相关的服务已经自动启动了，此时MySQL的密码为空，环境变量也需要手动去添加一下就OK了。
```
##　ERROR 1449 (HY000): The user specified as a definer (‘mysql.infoschema’@‘localhost’) does not exist
```bash

# 删除该用户
DROP USER 'mysql.infoschema'@'localhost';
# 再次创建这个用户
CREATE USER 'mysql.infoschema'@'localhost' IDENTIFIED BY 'yourpassword';
# 授予权限
GRANT SELECT ON *.* TO `mysql.infoschema`@`localhost`;
# 刷新权限
FLUSH PRIVILEGES;
```

## Linux 中 MySQL 忘记密码
1. 修改配置文件
```bash
# vim /etc/my.cnf

[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8mb4 

[mysqld]
# 设置3306端口
port = 3306 
# 设置mysql的安装目录
basedir=/usr/local/mysql
# 设置mysql数据库的数据的存放目录
datadir=/usr/local/mysql/data
# 允许最大连接数
max_connections=200
# 服务端默认编码（数据库级别）
character-set-server=utf8mb4
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB 
lower_case_table_names=1
max_allowed_packet=16M

# --- 添加此行到此处 ---
skip-grant-tables
```
2. 重启MySQL服务
```bash
systemctl restart mysql
```

3. 免密码登录 root 用户（输入密码时直接回车即可）

```bash
mysql -u root -p
```
4. 重置密码
```bash
mysql> use mysql
mysql> select host, user, authentication_string, plugin from user;
# 注意：先执行flush privileges;然后会alter成功，要不然会alter失败

mysql> alter user 'root'@'localhost'IDENTIFIED BY 'newpassword';
```
5. 修改密码安全级别
```bash
set global validate_password.policy=0;
set global validate_password.length=1;
```
6. 把/etc/my.cnf 文件末尾的 skip-grant-tables 去掉，重启MySQL服务，修改完成。

 


## sqlyog 链接 MySQL 数据库出现 2058 错误代码


## 多版本安装之后怎么访问不同版本 MySQL
```bash
# -h： 指定主机 -P：指定端口 -u：指定用户名 -p：指定密码
mysql -h 127.0.0.1 -P 3307 -u root -p
```

## MySQL8.x 强密码怎么取消
```bash
SHOW VARIABLES LIKE 'validate_password%';

set global validate_password.policy=LOW; 

set global validate_password.length=4;

set global validate_password.mixed_case_count=0;

set global validate_password.special_char_count=0;
```

## MySQL5.x 系列`msi`安装出现无响应问题
**问题剖析**：通常是由于3306端口号被占用导致的
**解决办法**：
1、可以通过`netstat -ano`查看端口号是否被占用
2、杀掉进程：
```bash
# 按进程 ID (PID) 杀死进程
taskkill /PID pid_number /F
# pid_number 是进程的 PID /F 参数表示强制终止进程。
```

## MySQL Connector Net 卸载不了
[点击下载微软官方的疑难解答：修复阻止安装或删除程序的问题](https://support.microsoft.com/en-us/topic/fix-problems-that-block-programs-from-being-installed-or-removed-cca7d1b6-65a9-3d98-426b-e9f927e1eb4d)

## MySQL管理用户权限
```bash
# 创建用户
mysql> create user 'root'@'%' identified by '123456';
# 授予权限
mysql> grant all privileges on *.* to 'root'@'%' with grant option;
# 刷新权限
mysql> flush privileges;
```

## 多平台重装MySQL，数据备份的需求

```bash
# 备份数据库
mysqldump -uroot -p --all-databases ~/db_backup/alldb_backup.sql
# 还原数据库
mysql -uroot -p < ~/db_backup/alldb_backup.sql
```

## MySQL远程访问问题

```mysql
1.进入mysql:
use mysql;
2.查看权限表：
select host,user from user;
3.修改root权限：
update user set host='%'where user='root';
4.设置密码永不过期
ALTER USER 'root'@'%' IDENTIFIED BY '新密码' PASSWORD EXPIRE NEVER;  //设置密码永不过期
4.再次查看表结果：
select host,user from user;
5.刷新
flush privileges;
```

## MySQL取消大小写敏感问题

```mysql
1.备份数据：在进行任何操作之前，请务必备份/var/ib/mysql目录中的数据，以防止数据丢失。

2.修改配置文件：打开/etc/mysql/my.conf文件，并在[mysqld]节下添加 lower_case_table_names=1 配置。

3.重新初始化数据库：运行以下命令进行数据库的重新初始化：
 sudo /usr/sbin/mysqld --initialize --user=root --lower-case-table-names=1
这个命令将重新初始化数据库并配置大小写不敏感设置。请注意，这将同时修改之前对密码的修改。

4.查询新的root密码：运行以下命令查找最新的root密码并记下：
 grep "A temporary password"/var/log/mysql/error.log
 
5.登录数据库：使用新的root密码登录MySQL:
 mysql -u root -p
 
6.修改密码：执行以下命令来修改新的密码为你所需的密码：
 ALTER USER 'root'@'localhost'IDENTIFIED WITH mysql_native_password BY 'root';
```

## MySQL启动服务提示权限不够问题

```bash
chown -R mysql:mysql /var/lib/mysql/
# MySQL 服务通常需要以 mysql 用户的身份运行，并且需要对数据目录拥有适当的读写权限。如果数据目录的所有者不是 mysql 用户，或者权限设置不当，MySQL 服务就无法正常启动。
```

## MySQL使用`mysqld --initialize`忘记加`--console`解决方法

```bash
# 查看安装MySQL的初始化密码
grep 'A temporary password' /var/log/mysqld.log
```

## MySQL5.6.+版本

### ERROR 1819 (HY000): 

Your password does not satisfy the current policy requirements.

```SQL
# 数据库中设置不了弱类型密码，会报以上错误
set global validate_password_policy=LOW;
```

### ERROR 1820 (HY000):

 You must reset your password using ALTER USER statement before executing this statement.

原因：MySQL版本5.6.6版本起，添加了password_expired(密码失效)功能，但是它的默认值是”N”，可以使用ALTER USER语句来修改这个值。

输入如下三个命令。

```sql
修改密码：
set password = password('admin');

禁用密码过期：
alter user root@localhost password expire never;

***组合命令：
alter user root@localhost identified by '新密码' password expire never;  （设置密码永不过期）

刷新权限：
flush privileges;
```

## MySQL 开启慢日志
```bash
[mysqld]
# 开启慢查询日志
slow_query_log = 1
# 慢查询日志文件路径（可自定义）
# slow_query_log_file = C:/ProgramData/MySQL/MySQL Server 8.0/Data/mysql-slow.log
slow_query_log_file = /usr/local/mysql/data/mysql-slow.log

# 定义慢查询的阈值（单位：秒，默认为10秒）
long_query_time = 2
# 是否记录不使用索引的查询
log_queries_not_using_indexes = 1
# 忽略的管理员命令（例如，不要记录 OPTIMIZE TABLE 等命令）
log_slow_admin_statements = 0
```
# win重装MySQL

## 残留清理
### 卸载MySQL
设置面板 > 应用 >　卸载MySQL
### 删除注册表
```bash
win + R 打开注册表
# 复制下面三条路径找到对应的注册表进行删除，没有就过，一般会存在第一个，第二三个不一定
计算机\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\MySQL

计算机\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\Eventlog\Application\MySQL

计算机\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Eventlog\Application\MySQL
```

### 停止并删除本地服务
```bash
# 查询本地安装的MySQL服务的名字
sc query | findstr "SERVICE_NAME" | findstr /I "MySQL"
# 停止并删除本地服务
sc stop <服务名称> && sc delete <服务名称>
# 再次验证默认端口号是否被占用，没有输出即可
netstat -ano | findstr "3306"
```

### 删除残留文件夹

```bash
# 默认安装位置
C:\Program Files\MySQL\
# 默认Data位置
C:\ProgramData\MySQL\
# 如果当时自定义安装的位置找不到或者记不清也没关系，只要服务删除了，就不起作用了
```
## MSI安装

### 安装地址
https://dev.mysql.com/downloads/installer/

### 双击msi文件进行安装

如果遇到最后一步**一直卡在start server那一步骤**，前往常见问题查看解决方法。

## .zip安装

### 安装地址

[MySQL Community Server --Archived Versions](https://downloads.mysql.com/archives/community/): https://downloads.mysql.com/archives/community/

### 5.6 及以下
> MySQL5.6 及以下版本的压缩包中是有 data 文件夹的，所以无需进行初始化，甚至不需要写配置文件，直接用默认配置文件：my-default.ini即可

```bash
# 打开cmd
cd “MySQL安装目录下的bin文件夹”
# 安装服务
mysqld.exe -install
# 启动服务
net start mysql
# 登录mysql，无密码直接回车
mysql -u root -p
# 设置密码
update mysql.user set password=password('123456') where User='root';
# 刷新权限
flush privileges;
# 设置环境变量
```

### 添加配置文件

> 在解压后的文件中添加`my.ini`配置文件，并将其中的`basedir`和`datadir`分别修改为自己的相应文件夹目录

#### v5.7
```ini
[mysqld]
#端口号
port = 3306
#mysql 根 路径
basedir=D:\MySQL57
#mysql data 路径
datadir=D:\MySQL57\data
 
#最大连接数
max_connections=200
#编码
character-set-server=utf8
default-storage-engine=INNODB
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
 
[mysql]
#编码
default-character-set=utf8
```

#### v8.x详细

```ini
[mysql]
#设置mysql客户端默认字符集
default-character-set=utf8mb4
[mysqld]
# 避免MySQL的外部锁定，减少出错几率增强稳定性。
skip-external-locking
# 禁用dns解析，避免网络DNS解析服务引发访问MYSQL的错误，一般应当启用。
skip-name-resolve
#设置3306端口
port=3306
# 服务端使用的字符集默认为8比特编码的latin1字符集  
character-set-server=utf8mb4
# 设置mysql的安装目录  
basedir=D:/Soft/Work/mysql-8.0.28
# 设置mysql数据库的数据的存放目录  
datadir=D:/Soft/Work/mysql-8.0.28/data 
# 允许最大连接数  
max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集  
character-set-server=utf8mb4  
# 创建新表时将使用的默认存储引擎  
default-storage-engine=INNODB
# InnoDB事务在放弃前等待行锁的时间（秒
innodb_lock_wait_timeout=50
# 索引缓冲区的大小:最大可以设置80%内存
innodb_buffer_pool_size = 1024M
# 指定大小的内存来缓冲数据和索引
key_buffer_size = 32M
# 针对交互式连接:在mysql_real_connect()函数中使用了CLIENT_INTERACTIVE选项。超时时间
interactive_timeout=880000
# 对非交互式连接:通过jdbc连接数据库是非交互式连接 超时时间
wait_timeout=880000
# 单次传输包大小
max_allowed_packet=200M
# 隔离级别：read-committed：读提交，不允许脏读，但允许不可重复读；
transaction-isolation = READ-COMMITTED
# 指定大小的内存来缓冲数据和索引
key_buffer_size = 32M
# 当连接失败达到max_connect_error设置的次数，该host将被锁定
max_connect_errors=1000
```

#### v8.x简易

```ini
[mysqld]
# 设置3306端口
port=3306
# 设置mysql的安装目录
basedir=D:/MySQL
# 设置mysql数据库的数据的存放目录
datadir=D:/MySQL/data
# 允许最大连接数
max_connections=200
# 允许连接失败的次数。这是为了防止有人从该主机试图攻击数据库系统
max_connect_errors=10
# 服务端使用的字符集默认为UTF8
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
# 默认使用“mysql_native_password”插件认证
default_authentication_plugin=mysql_native_password
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
[client]
# 设置mysql客户端连接服务端时默认使用的端口
port=3306
default-character-set=utf8
```
#### v8.4简易

```ini
[mysqld]
# 设置3306端口
port=3306
# 设置mysql的安装目录
basedir=D:/MySQL
# 设置mysql数据库的数据的存放目录
datadir=D:/MySQL/data
# 允许最大连接数
max_connections=200
# 允许连接失败的次数。这是为了防止有人从该主机试图攻击数据库系统
max_connect_errors=10
# 服务端使用的字符集默认为UTF8
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
# MySQL8.4版本及以上添加，启用验证密码插件解决workbench以及sqlyog连接问题（非8.4及以上无需添加）
mysql_native_password=ON

[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
[client]
# 设置mysql客户端连接服务端时默认使用的端口
port=3306
default-character-set=utf8
```

### 初始化数据库

以管理员身份运行cmd，并切换目录至mysql主目录的bin文件夹下，输入如下命令：

```shell
# 初始化mysql数据库，自动创建data文件夹，可在控制台打印的日志信息查看到初始化的数据库密码
mysqld --initialize --console

# 注意：如果以上命令没有加--console，在cmd窗口就不会显示日志信息，可以在data文件夹找一个后缀为.err的文件，也能查看日志信息。
mysqld --initialize （不建议使用，生成一个随机的root密码）
# ⭐⭐⭐
mysqld --initialize-insecure --user=mysql （建议使用，密码为空）
```

### 注册mysql服务并启动

> 使用下边的命令可以注册mysql服务，需要安装多个版本mysql时可以使用这个命令来区分不同版本数据库对应的服务。

```shell
mysqld --install 服务名称
sc start 服务名称
```

### 登录mysql数据库

```shell
# 使用如下命令进行登录
mysql -uroot -p
# 输入刚才控制台初始化的密码信息
```

### 修改密码

```sql
# 进入MySQL命令行
mysql -u root

# 切换数据库
use mysql；

# 注意版本要求：

export MAVEN_HOME=/usr/local/apache-maven-3.6.3
export PATH=$PATH:$MAVEN_HOME/bin

# V5.6 及以下版本
update mysql.user set password=password('123456') where User='root';
或 
update mysql.user set authentication_string=password('123456') where User='root';

# V5.7 及以上版本
alter user root@localhost identified by '新密码' password expire never;  （推荐使用！设置密码永不过期）
或
alter user root@localhost identified by '新密码';
或
set password for root@localhost = '新密码';
```

# Linux重装MySQL

## CentOS

### 卸载

采用yum安装mysql后，如果想要完全卸载mysql，可以采用如下方式：
#### 查找并删除mysql安装内容
![img](https:////upload-images.jianshu.io/upload_images/7802645-bfcd164758838157.png?imageMogr2/auto-orient/strip|imageView2/2/w/584/format/webp)

```bash
# 是用rpm命令查询mysql安装包
rpm -qa |grep -i mysql

# 删除mysql安装包
yum remove mysql-community-common-5.7.20-1.el7.x86_64
yum remove mysql-community-client-5.7.20-1.el7.x86_64
yum remove mysql57-community-release-el7-11.noarch
yum remove mysql-community-libs-5.7.20-1.el7.x86_64
yum removemysql-community-server-5.7.20-1.el7.x86_64

# 再次确认删除干净
rpm -qa |grep -i mysql
```


#### 删除文件残留
![img](https:////upload-images.jianshu.io/upload_images/7802645-f334e2d6474898a9.png?imageMogr2/auto-orient/strip|imageView2/2/w/412/format/webp)

```bash
find / -name mysql

rm -rf /etc/my.cnf

rm -rf /var/log/mysqld.log

rm -f /tmp/mysqlx.sock.lock
rm -f /tmp/mysqlx.sock

# 这两个文件删除一次后会生成新的，删除一次即可
rm -f /tmp/mysql.sock.lock
rm -f /tmp/mysql.sock
```


### 重装

#### 在线安装

安装包网址：https://dev.mysql.com/downloads/repo/yum/

##### 下载wget命令

```bash
yum install -y wget
```

##### 下载MySQL安装包

```bash
# 根据上面的安装包网址中的链接，根据需要选择
wget https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
```

##### 安装MySQL安装包

```bash
rpm -ivh mysql57-community-release-el7-8.noarch.rpm
```

##### 安装MySQL服务

```bash
# 1. 进入 /etc/yum.repos.d 目录
cd /etc/yum.repos.d
# 2. 安装MySQL服务
yum -y install mysql-server


#  注意：在安装过程中可能会遇到以下类似问题：

源 “MySQL 5.7 Community Server” 的 GPG 密钥已安装,但是不适用于此软件包。请检查；

从 file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql 检索密钥
源 "MySQL 5.7 Community Server" 的 GPG 密钥已安装，但是不适用于此软件包。请检查源的公钥 URL 是否配置正确。
失败的软件包是：mysql-community-server-5.7.37-1.el7.x86_64
GPG  密钥配置为：file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

# 解决方案：可在安装出现问题后执行下面代码，这段代码执行完成后再来执行安装服务

rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
```

##### 启动MySQL服务

```bash
systemctl start mysqld.service
```

##### 查看数据库初始密码

```bash
grep 'A temporary password' /var/log/mysqld.log
```

##### 修改密码

   > 老一套

##### 远程访问解决

   > 可以通过关闭防火墙以及增加防火墙开放端口  ＋  老一套

#### 内网环境 zip 安装
[参考链接](https://blog.csdn.net/LIU_ZHAO_YANG/article/details/135628320)

##### 可能遇到的问题
- 安装 MySQL57 时提示系统中缺少 ncurses 库
  ![提示系统中缺少ncurses库报错图](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/备忘录-2025-02-11-02-56-12.png)
  - 科普：
  libncurses.so.5 是一个终端控制库的共享文件，MySQL 5.7 客户端依赖它来运行。如果系统中缺少该文件，可以通过安装兼容包、创建符号链接或升级 MySQL 版本来解决问题。推荐优先尝试安装兼容包或升级到 MySQL 8.0。

  - 原因：
  某些较新的 Linux 发行版（如 CentOS 8 或 Ubuntu 20.04 及以上版本）可能默认不安装 ncurses 的旧版本（如 ncurses5），而是使用更新的版本（如 ncurses6）。
  MySQL 5.7 客户端可能硬编码依赖 libncurses.so.5，而无法直接使用 libncurses.so.6。
  - 解决办法：
    ```bash
    # 系统中已装 ncurses6，可以创建软连接
    sudo ln -s /lib/x86_64-linux-gnu/libncurses.so.6 /lib/x86_64-linux-gnu/libncurses.so.5
    
    # 系统中未装 ncurses
    ## Ubuntu
    sudo apt-get install libncurses5
    ## CentOS
    sudo yum install ncurses-libs
    ```
- 初始化 MySQL57 时提示系统缺少 libaio 库
  - 报错信息：
    ```bash
    ./bin/mysqld: error while loading shared libraries: libaio.so.1: cannot open shared object file: No such file or directory
    ```
  - 解决方法：
    ```bash
    # Ubuntu
    sudo apt install libaio1
    # CentOS
    sudo yum install libaio
    # 如果 Ubuntu 提示如下内容，需要更换源
    apt-get install libaio1
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    E: Unable to locate package libaio1
    [参考链接](https://blog.csdn.net/NowJzy/article/details/142459713)
    ```

  
##### 编辑配置文件
```bash
# 下载安装包
wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.27-linux-glibc2.12-x86_64.tar.xz
#  vi /etc/my.cnf

[mysqld]
# 设置3306端口
port=3306
# 设置mysql的安装目录
basedir=/usr/local/mysql
# 设置mysql数据库的数据的存放目录
datadir=/usr/local/mysql/data
# 允许最大连接数
max_connections=200
# 允许连接失败的次数。
max_connect_errors=10
# 服务端使用的字符集默认为utf8mb4
character-set-server=utf8mb4
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
# 默认使用“mysql_native_password”插件认证
#mysql_native_password
default_authentication_plugin=mysql_native_password
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8mb4
[client]
# 设置mysql客户端连接服务端时默认使用的端口
port=3306
default-character-set=utf8mb4
```
##### 初始化MySQL（二选一）
```bash
./bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data

./mysqld --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql --initialize
```

##### 设置开机自启动
```bash
# 新建文件并编辑
vi /etc/systemd/system/mysql.service

# 根据自己的安装位置，输入一下内容
[Unit]
Description=MySQL Server
Documentation=https://dev.mysql.com/doc/refman/5.7/en/

[Service]
ExecStart=/usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf
User=mysql
Group=mysql
Restart=always
RestartSec=3
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target

# 重新加载配置文件
systemctl daemon-reload
# 

systemctl enabled mysql

systemctl is-enabled mysql


# 重启mysql服务并查看状态
systemctl restart mysql
systemctl status mysql
```

## Ubuntu
```bash
###   一般不用这些 ###
sudo apt-get purge mysql*
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get dist-upgrade
###   若是执行 apt remove mysql-server 报错 则执行以上命令  ###

# 先检查当前主机是否已经下载了mysql或者mariadb
dpkg -l | grep mysql-server
dpkg -l | grep mariadb

# 如果有返回结果，那么就是已经下载安装了。

# 卸载曾经的mysql或mariadb环境
apt remove mysql-server
apt remove mariadb

# 下载安装mysql
apt install -y mysql-server

# 查看安装并启动mysql服务
# 对于安装的不同版本，有些mysql版本在下载安装时就已经默认开启了服务。有些则需要手动打开服务。
# 查看是否打开mysql服务
systemctl status mysql

```

# MAC重装MySQL



## DMG方式安装

### 卸载`MySQL`

打开系统设置，进入侧边栏最底部的`MySQL`一栏

### 删除安装残余

```bash
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/MySQL*



@echo off
set MINIO_ROOT_USER=minioadmin
set MINIO_ROOT_PASSWORD=minioadmin
minio.exe server D:\Minio\data --console-address ":9001" --address ":9000" > D:\Minio\logs\minio.log 2>&1
sudo rm -f /tmp/mysqlx.sock.lock
sudo rm -f /tmp/mysqlx.sock

# 这两个文件删除一次后会生成新的，新生成的不用删除
sudo rm -f /tmp/mysql.sock.lock
sudo rm -f /tmp/mysql.sock

# 这是授权的命令，但是很多时候不管用，如果是通过 brew 的方式进行安装的 MySQL 的话，一定要执行
chmod -R 777 /opt/homebrew/var/mysql
```

### 重新安装

完成后查看系统设置，进入侧边栏最底部的`MySQL`一栏，查看是否正常启动，已经启动则成功安装

### 配置环境变量

```bash
# 查看环境变量是否写入
cat ~/.bash_profile
# 如果未写入
echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile 
```

## Compressed TAR Archive压缩包方式安装

官网地址：https://dev.mysql.com/downloads/mysql/

### 删除`MySQL`压缩包以及解压后的文件

```bash
rm -rf ./file/*
```

### 删除安装残余

```bash
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/MySQL*

sudo rm-f /tmp/mysqlx.sock.lock
sudo rm -f /tmp/mysqlx.sock

# 这两个文件删除一次后会生成新的，新生成的不用删除
sudo rm -f /tmp/mysql.sock.lock
sudo rm -f /tmp/mysql.sock

# 这是授权的命令，但是很多时候不管用，如果是通过 brew 的方式进行安装的 MySQL 的话，一定要执行
chmod -R 777 /opt/homebrew/var/mysql
```

### 解压

将其解压到/usr/local/下，并重命名为mysql (即：最后的完整目录应该是/usr/local/mysql)

#### 调整目录权限

```bash
cd /usr/local
# 这一步的目的，主要是保证/usr/local/mysql下可以写入数据
chown -R 当前登录mac的管理员用户名 mysql
```

#### 初始化数据库

```
cd /usr/local/mysql/bin
sudo ./mysqld --initialize --user=mysql
```



> 2018-12-01T14:42:12.002186Z 0 [System] [MY-013169] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.13) initializing of server in progress as process 4229
> 2018-12-01T14:42:12.004783Z 0 [Warning] [MY-010159] [Server] Setting lower_case_table_names=2 because file system for /usr/local/mysql/data/ is case insensitive
> 2018-12-01T14:42:12.006285Z 0 [Warning] [MY-010122] [Server] One can only use the --user switch if running as root
> 2018-12-01T14:42:14.187443Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: **iM46X&03qRc_**
> 2018-12-01T14:42:15.427614Z 0 [System] [MY-013170] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.13) initializing of server has completed



**注意加粗的部分**，初始化过程中，会生成一个随机的root初始密码，记好这个，后面会用到。

如果没记下这个密码，导致后面无法登录，可以**rm -rf /usr/local/mysql/data/*** 把所有文件干掉，再来一把。

#### 启动mysql

```bash
cd /usr/local/mysql/support-file

./mysql.server start
```

Starting MySQL
. SUCCESS!

看到这个SUCCESS就表示启动成功了。

```text
# 在启动MySQL时报：[ERROR] Fatal error: Please read “Security” section of the manual to find out how to run mysqld as root!

1. 使用root用户启动
service mysqld start --user=root

2. 使用非root用户启动，修改my.cnf文件
进入文件：vim /etc/my.cnf
在[mysqld]下输入内容：user=mysql
```

#### 修改密码

```
cd /usr/local/mysql/bin
./mysqladmin -u root -p '新的密码'
```

初始密码实在太难记了，可以用上面的命令先改一下

这一步做完后，应该就可以用

#### 登录验证

```bash
mysql -u root -p
```

不过**8.0及以上版本**貌似安全策略做了调整，用navicat之类的工具连接，会出现：**Client does not support authentication protocol requested by server; consider upgrading MySQL client**之类的错误

解决方法：

```bash
use mysql
alter user 'root'@'localhost' identified with mysql_native_password by '新密码';
flush privileges;
```

#### 配置全局环境变量

```bash
# 查看环境变量是否写入
cat ~/.bash_profile
# 如果未写入
echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

#### 设置开机自启动

```bash
# 1. 创建启动代理 plist 文件（保存文件并退出编辑器（在 nano 中，按 ctrl+x，然后按 y，然后 enter）
sudo nano /library/launchdaemons/com.mysql.mysql.plist

# 2. 将以下内容添加到文件中
<?xml version="1.0" encoding="utf-8"?>
<!doctype plist public "-//apple//dtd plist 1.0//en" "http://www.apple.com/dtds/propertylist-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>label</key>
    <string>com.mysql.mysql</string>
    <key>programarguments</key>
    <array>
      <string>/usr/local/mysql/support-files/mysql.server</string>
      <string>start</string>
    </array>
    <key>runatload</key>
    <true/>
  </dict>
</plist>

# 3. 为plist文件设置正确的权限
sudo chown root:wheel /library/launchdaemons/com.mysql.mysql.plist
sudo chmod 644 /library/launchdaemons/com.mysql.mysql.plist

# 4. 加载启动代理
sudo launchctl load /Library/LaunchDaemons/com.mysql.mysql.plist
```

# Windows忘记MySQL密码

> 如果是忘记密码，那么需要按照顺序全部执行；如果仅仅是修改密码，只需执行第四步即可！

1. `win + R`运行`services.msc`

   找到`MySQL`或者`MySQL80`服务并关闭

2. 以管理员身份运行`cmd`，进入MySQL安装目录

   ```bash
   # 默认安装位置
   C:\Program Files\MySQL\MySQL Server [your_version]\bin
   # 正确配置过环境变量的前提下，找不到安装目录可以使用以下命令进行查看
   where mysqld.exe
   ```

3. 跳过权限表启动`MySQL`

   ```bash
   # 在 bin 目录下执行命令，跳过身份验证权限，运行以下命令之后，此时命令提示符处于mysqld启动状态
   mysqld --skip-grant-tables
   ```

4. 修改密码

   ```bash
   # 新打开一个 cmd 连接到 MySQL
   # 进入MySQL命令行
   mysql -u root
   
   # 切换数据库
   use mysql；
   
   # 注意版本要求：
   # 小于等于 V5.7 
   update mysql.user set authentication_string=password('123456') where User='root';
   # 大于 V5.7
   alter user root@localhost identified by '新密码' password expire never;  （推荐使用！设置密码永不过期）
   
   update mysql.user set password=password('123456') where User='root';
   或者
   alter user root@localhost identified by '新密码';
   或者
   set password for root@localhost = '新密码';
   ```

5. 刷新权限

   ```bash
   flush privileges;
   ```

6. 验证是否成功



# MAC忘记MySQL密码

> 如果是忘记密码，那么需要按照顺序全部执行；如果仅仅是修改密码，只需执行第五步即可！

1. 关闭`MySQL`服务

   > 1 使用系统设置页的 MySQL 面板
   >
   > 2 使用命令
   >
   > ```bash
   > sudo /usr/local/mysql/support-files/mysql.server stop
   > ```

2. 切换到管理员模式

   ```bash
   sudo su
   ```

3. 关闭密码验证

   ```bash
   # 跳过权限表，执行下面的语句后，直接后台启动运行，可能不需要新开终端
   sudo /usr/local/mysql/bin/mysqld_safe --skip-grant-tables &
   ```

4. 进入`MySQL`

   ```bash
   mysql -u root
   ```

5. 刷新权限
   ```bash
   flush privileges;
   ```

6. 修改密码

   ```bash
   # 注意版本要求：
   # 小于等于 V5.7 
   update mysql.user set authentication_string=password('123456') where User='root';
   
   # 大于 V5.7
   alter user root@localhost identified by '新密码' password expire never;  （推荐使用！设置密码永不过期）
   
   update mysql.user set password=password('123456') where User='root';
   或者
   alter user root@localhost identified by '新密码';
   或者
   set password for root@localhost = '新密码';
   ```

6. 刷新权限

   ```bash
   flush privileges；
   ```

7. 开启`MySQL`服务

   > 同第一步⬆️，第一步用什么方法，这一步就用什么
   >
   > 1 使用系统设置页的 MySQL 面板
   >
   > 2 使用命令
   >
   > ```bash
   > sudo /usr/local/mysql/support-files/mysql.server start
   > ```

# MAC启动MySQL服务报错

[参考链接](https://blog.csdn.net/l1994m/article/details/140016220)

## 报错

ERROR!The server quit without update PID file（/opt/homebrew/var/mysql/username.local.pid）

## 原因

安装MySQL时，之前的配置为删除干净，或者未卸载干净导致系统进程中残留了MySQL相关服务的进程！

## 解决方案

```bash
sudo cat /opt/homebrew/var/mysql/username.local.err

sudo rm-f /tmp/mysqlx.sock.lock

sudo rm -f /tmp/mysqlx.sock

# 这两个文件删除一次后会生成新的，新生成的不用删除
sudo rm -f /tmp/mysql.sock.lock

sudo rm -f /tmp/mysql.sock

# 这是授权的命令，但是很多时候不管用
chmod -R 777 /opt/homebrew/var/mysql

# 重新开启MySQL服务
1 如果是使用的mac系统的dmg方式进行安装的，打开系统设置尾部的 MySQL 面板进行
2 使用命令
sudo /usr/local/mysql/support-files/mysql.server start
```

# MAC启动MySQL的方式
## 通过`homebrew`安装的MySQL
```bash
brew services start mysql
```
## 通过`DMG`安装的MySQL
打开设置面板最下方的 MySQL panel 进行启动
## 通过`Compressed TAR Archive`压缩包安装
```bash
# 进入MySQL的安装目录
cd "你实际安装的位置"
# 启动服务
./support-files/mysql.server start
# 验证MySQL服务的状态
./support-files/mysql.server status
```