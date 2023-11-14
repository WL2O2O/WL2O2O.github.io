---
title: Redis学习笔记
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309111618302.png
categories:
  - Java notes
tags:
  - Redis
abbrlink: 30038
date: 2022-10-27 20:27:45
---

> 1. 阅读Redis官方文档：Redis官方文档是学习Redis的最佳资源之一，它提供了全面的介绍和指导，包括数据结构、命令、配置和部署等方面的内容。可以从Redis官方网站上获取最新版本的文档。
>2. 掌握Redis的基本数据结构：Redis支持多种数据结构，如字符串、哈希、列表、集合和有序集合等。要深入了解Redis，必须掌握这些基本数据结构，以及它们的操作和用途。
> 3. 实践：阅读Redis文档仅仅是开始，最重要的是实践。使用Redis CLI或者客户端库来执行一些命令，创建一些数据结构，并且观察其行为。尝试使用不同的数据结构和命令，以及探索Redis的一些高级特性，如事务和Lua脚本等。
> 4. 学习Redis的应用场景：Redis有很多应用场景，如缓存、消息队列、计数器、排行榜等等。学习这些应用场景可以帮助你更好地理解Redis的特性和优势。
> 5. 学习Redis的高级特性：Redis还有很多高级特性，如发布订阅、Lua脚本、事务、持久化、集群等。学习这些特性可以帮助你更好地利用Redis来构建复杂的应用。
> 6. 阅读Redis源代码：如果你想深入了解Redis的实现细节，阅读Redis的源代码是一个很好的方式。可以通过GitHub获取Redis的源代码，并尝试阅读和理解其中的实现。
> 7. 参加Redis社区：Redis社区是一个非常活跃的社区，有很多专家和开发者会在社区中分享他们的经验和见解。参加Redis社区可以帮助你更好地了解Redis，并与其他Redis用户和开发者互动。
> 
> 总之，要系统和高效地学习Redis，需要全面了解Redis的基本概念和数据结构，掌握Redis的应用场景和高级特性，进行实践和尝试，并参加Redis社区。

# 黑马Redis

## Redis介绍

简介：什么是Redis？Redis是一种基于键值对的非关系型数据库。

优点：

* 满足很多使用场景。Redis数据库比一般的键值对数据库要强大很多，Redis中的value支持多种数据类型与数据结构，例如：String、hash、list、Set、zset（有序集合）、Bitmaps（位图）、HyperLogLog、GEO（地理信息定位）等。![Redis基本数据结构](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-10434dc7-c7a3-4c1a-b484-de3fb37669ee.png)
* 基于内存，读写性能出色。同时内存数据可定时通过快照和日志的形式保存到硬盘之上，做到断电不丢失。
* 还提供了键过期、发布订阅、事物、流水线、Lua脚本等附加功能。

应用领域：

* 缓存：应用最广的地方，很多web应用都会选择使用Redis作为缓存，以降低数据源压力，提高响应速度。![Redis缓存](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-d44c2397-5994-452f-8b7b-eb85d2b87685.png)
* 计数器：天然计数功能，可用来记录浏览量、点赞量等
* 排行榜：借助Redis提供的列表和有序集合数据结构，合理使用数据结构构建排行榜系统
* 社交网络：点赞与差评、粉丝、共同好友、推送、刷新
* 消息队列：提供了发布订阅的功能和阻塞队列的功能，可以满足一般消息队列功能
* 分布式锁：分布式环境下，利用Redis是西安分布式锁



![Redis数据结构介绍](http://images.rl0206.love/202305021641013.png)

Redis有五种基本数据结构。

**`string`**

字符串最基础的数据结构。字符串类型的值实际可以是字符串（简单的字符串、复杂的字符串（例如JSON、XML））、数字 （整数、浮点数），甚至是二进制（图片、音频、视频），但是值最大不能超过512MB。

字符串主要有以下几个典型使用场景：

- 缓存功能
- 计数
- 共享Session
- 限速

**`hash`**

哈希类型是指键值本身又是一个键值对结构。

哈希主要有以下典型应用场景：

- 缓存用户信息
- 缓存对象

**`list`**

列表（list）类型是用来存储多个有序的字符串。列表是一种比较灵活的数据结构，它可以充当栈和队列的角色

列表主要有以下几种使用场景：

- 消息队列
- 文章列表

**`set`**

集合（set）类型也是用来保存多个的字符串元素，但和列表类型不一 样的是，集合中不允许有重复元素，并且集合中的元素是无序的。

集合主要有如下使用场景：

- 标签（tag）
- 共同关注

**`sorted set`**

有序集合中的元素可以排序。但是它和列表使用索引下标作为排序依据不同的是，它给每个元素设置一个权重（score）作为排序的依据。

有序集合主要应用场景：

- 用户点赞统计
- 用户排序

Redis为什么快？

> Redis的速度⾮常的快，单机的Redis就可以⽀撑每秒十几万的并发，相对于MySQL来说，性能是MySQL的⼏⼗倍。速度快的原因主要有⼏点：

* 完全基于内存
* 使用单线程，避免线程切换和竟态产生的消耗
* 基于非阻塞的IO多路复用机制
* C语言实现，优化过的数据结构基于几种基本的数据结构，Redis做了大量优化，性能高

怎么理解多路复用？

> 引用知乎上一个高赞的回答来解释什么是I/O多路复用。假设你是一个老师，让30个学生解答一道题目，然后检查学生做的是否正确，你有下面几个选择：

- 第一种选择：按顺序逐个检查，先检查A，然后是B，之后是C、D。。。这中间如果有一个学生卡住，全班都会被耽误。这种模式就好比，你用循环挨个处理socket，根本不具有并发能力。
- 第二种选择：你创建30个分身，每个分身检查一个学生的答案是否正确。 这种类似于为每一个用户创建一个进程或者- 线程处理连接。
- 第三种选择，你站在讲台上等，谁解答完谁举手。这时C、D举手，表示他们解答问题完毕，你下去依次检查C、D的答案，然后继续回到讲台上等。此时E、A又举手，然后去处理E和A。

第一种就是阻塞IO模型，第三种就是I/O复用模型。

![I/O模型](http://images.rl0206.love/202305021556308.png)

Redis如何数据持久化？

> Redis是完全基于内存的，要想避免数据断电丢失，就必须把数据持久化，数据持久化的方式有两种：RDB、AOF

* RDB：RDB持久化是把当前进程数据生成快照保存到硬盘的过程，触发RDB持久化过程分为手动触发和自动触发。RDB⽂件是⼀个压缩的⼆进制⽂件，通过它可以还原某个时刻数据库的状态。由于RDB⽂件是保存在硬盘上的，所以即使Redis崩溃或者退出，只要RDB⽂件存在，就可以⽤它来恢复还原数据库的状态。

  * 手动触发分别对应save和bgsave命令: ![save和bgsave](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-ffe56e32-34c5-453d-8859-c2febbe6a038.png)
    - save命令：阻塞当前Redis服务器，直到RDB过程完成为止，对于内存比较大的实例会造成长时间阻塞，线上环境不建议使用。
    - bgsave命令：Redis进程执行fork操作创建子进程，RDB持久化过程由子进程负责，完成后自动结束。阻塞只发生在fork阶段，一般时间很短。
  * 以下场景会自动触发RDB持久化：
    * 使用save相关配置，如“save m n”。表示m秒内数据集存在n次修改时，自动触发bgsave。
    * 如果从节点执行全量复制操作，主节点自动执行bgsave生成RDB文件并发送给从节点
    * 执行debug reload命令重新加载Redis时，也会自动触发save操作
    * 默认情况下执行shutdown命令时，如果没有开启AOF持久化功能则自动执行bgsave。

* AOF（append only file）持久化：以独立日志的方式记录每次写命令， 重启时再重新执行AOF文件中的命令达到恢复数据的目的。AOF的主要作用是解决了数据持久化的实时性，目前已经是Redis持久化的主流方式

  * AOF的工作流程操作：命令写入 （append）、文件同步（sync）、文件重写（rewrite）、重启加载 （load） 

    ![AOF工作流程](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-a9fb6202-b1a1-484d-a4fa-fef519090b44.png)

  * 流程如下：

    * 1）所有的写入命令会追加到aof_buf（缓冲区）中。
    * 2）AOF缓冲区根据对应的策略向硬盘做同步操作。
    * 3）随着AOF文件越来越大，需要定期对AOF文件进行重写，达到压缩 的目的。
    * 4）当Redis服务器重启时，可以加载AOF文件进行数据恢复。






## Redis命令 

[redis帮助文档](https://redis.io/commands/)

![image-20230416091404745](http://images.rl0206.love/202305021641017.png)

![image-20230416092238674](http://images.rl0206.love/202305021641018.png)

![image-20230416093225232](http://images.rl0206.love/202305021641019.png)

![image-20230416094344011](http://images.rl0206.love/202305021641020.png)

![image-20230416100340583](http://images.rl0206.love/202305021641021.png)

![image-20230416100753096](http://images.rl0206.love/202305021641022.png)

![image-20230416101608129](http://images.rl0206.love/202305021641023.png)

![image-20230416101850417](http://images.rl0206.love/202305021641024.png)

![image-20230416102809805](http://images.rl0206.love/202305021641026.png) 

![image-20230416103712554](http://images.rl0206.love/202305021641027.png)

![image-20230416105319879](http://images.rl0206.love/202305021641028.png)

注意：所有的排名都是升序，若要降序，则在Z的后面加REV即可。

## Redis进阶

>什么是主从复制？

* **主从复制**，是指将一台 Redis 服务器的数据，复制到其他的 Redis 服务器。前者称为 **主节点(master)**，后者称为 **从节点(slave)**。且数据的复制是 **单向** 的，只能由主节点到从节点。Redis 主从复制支持 **主从同步** 和 **从从同步** 两种，后者是 Redis 后续版本新增的功能，以减轻主节点的同步负担。

![主从复制图](http://images.rl0206.love/202305031511055.png)

>主从复制什么作用？

- **数据冗余：** 主从复制实现了数据的**热备份**，是持久化之外的一种数据冗余方式。
- **故障恢复：** 当主节点出现问题时，可以由从节点提供服务，实现快速的故障恢复 *(实际上是一种服务的冗余)*。
- **负载均衡：** 在主从复制的基础上，配合读写分离，可以由主节点提供写服务，由从节点提供读服务 *（即写 Redis 数据时应用连接主节点，读 Redis 数据时应用连接从节点）*，分担服务器负载。尤其是在写少读多的场景下，通过多个从节点分担读负载，可以大大提高 Redis 服务器的并发量。
- **高可用基石：** 除了上述作用以外，主从复制还是哨兵和集群能够实施的 **基础**，因此说主从复制是 Redis 高可用的基础。

> Redis主从有几种常见的拓扑结构？

Redis的复制拓扑结构可以支持单层或多层复制。

根据拓扑结构的复杂性可以分为三种：一主一从、一主多从、树状主从。

* 一主一从结构

  * 一主一从结构是最简单的复制拓扑结构。应用场景：用于主节点出现宕机时从节点提供故障转移支持（故障恢复）

    ![](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-5d91a67c-dbff-4a8d-bf9d-1fe7602d5a27.png)

* 一主多从

  * 一主多从结构（又称星形拓扑结构）。应用场景：使得应用端可以利用多个从节点实现读写分离，对于读占比较大的场景，可以把读命令发送到从节点来分担主节点压力（负载均衡）。

    ![](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-71074254-699a-480b-bbb0-c68f364a380b.png)

* 树状主从

  * 树状主从结构（又称树状拓扑结构）。应用场景：使得从节点不但可以复制主节点数据，同时可以作为其他从节点的主节点继续向下层复制。通过引入复制中间层，可以有效降低主节点负载和需要传送给从节点的数据量（负载均衡）。

    ![](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-dff14203-5e01-4d1b-a775-10ee444ada54.png)



上面说了什么是？什么用？ 以及常见的拓扑结构，接下来详细说一说主从的基本原理，一起搞懂Redis主从吧！

> Redis主从复制原理？

Redis主从复制的工作流程大概可以分为如下几步：（官方文档翻译后的答案）
1、保存主节点（master）信息 这一步只是保存主节点信息，保存主节点的ip和port。
2、主从建立连接 从节点（slave）发现新的主节点后，会尝试和主节点建立网络连接。
3、发送ping命令 连接建立成功后从节点发送ping请求进行首次通信，主要是检测主从之间网络套接字是否可用、主节点当前是否可接受处理命令。
4、权限验证 如果主节点要求密码验证，从节点必须正确的密码才能通过验证。
5、同步数据集 主从复制连接正常通信后，主节点会把持有的数据全部发送给从节点。
6、命令持续复制 接下来主节点会持续地把写命令发送给从节点，保证主从数据一致性。

![Redis主从复制工作流程](http://images.rl0206.love/202305031556969.png)

```
Redis主从复制的工作流程如下：（GPT给的2.8以下版本的Redis）

1. 当一个Redis从服务器连接到主服务器时，它会向主服务器发送一个SYNC命令，请求同步数据。
2. 主服务器接收到SYNC命令后，会开启一个后台线程，将所有写命令记录到一个缓冲区中，同时将缓冲区中的数据发送给从服务器。
3. 从服务器接收到数据后，将其存储在自己的数据库中，并向主服务器发送一个ACK命令，表示已经接收到数据。
4. 主服务器接收到ACK命令后，将缓冲区中的数据删除，并继续等待新的写命令。如果从服务器断开连接，主服务器会尝试重新连接。
5. 当主服务器发生故障或者重启时，从服务器会重新连接到主服务器，并请求同步数据。此时，主服务器会将所有未同步的数据发送给从服务器，并重新开始记录写命令。
6. 如果主服务器在同步数据时出现错误，从服务器会断开连接，并尝试重新连接到主服务器。如果多次尝试失败，从服务器会成为一个新的主服务器。

总的来说，Redis主从复制的工作流程是基于异步复制的，主服务器不会等待从服务器的响应，而是将数据发送给从服务器后立即返回。这种方式可以提高性能，但也有可能会导致数据不一致的问题。因此，在使用Redis主从复制时，需要注意数据一致性的问题
```



> 主从数据同步的方式？

Redis在2.8及以上版本使用psync命令完成主从数据同步，同步过程分为：全量复制和部分复制。

1. **全量复制** 一般用于初次复制场景，Redis早期支持的复制功能只有全量复制，它会把主节点全部数据一次性发送给从节点，当数据量较大时，会对主从节点和网络造成很大的开销。

   全量复制的完整运行流程如下： ![全量复制](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-aa8d2960-b341-49cc-b04c-201241fd15de.png)

   1. 发送psync命令进行数据同步，由于是第一次进行复制，从节点没有复制偏移量和主节点的运行ID，所以发送psync-1。
   2. 主节点根据psync-1解析出当前为全量复制，回复+FULLRESYNC响应。
   3. 从节点接收主节点的响应数据保存运行ID和偏移量offset
   4. 主节点执行bgsave保存RDB文件到本地
   5. 主节点发送RDB文件给从节点，从节点把接收的RDB文件保存在本地并直接作为从节点的数据文件
   6. 对于从节点开始接收RDB快照到接收完成期间，主节点仍然响应读写命令，因此主节点会把这期间写命令数据保存在复制客户端缓冲区内，当从节点加载完RDB文件后，主节点再把缓冲区内的数据发送给从节点，保证主从之间数据一致性。
   7. 从节点接收完主节点传送来的全部数据后会清空自身旧数据
   8. 从节点清空数据后开始加载RDB文件
   9. 从节点成功加载完RDB后，如果当前节点开启了AOF持久化功能， 它会立刻做bgrewriteaof操作，为了保证全量复制后AOF持久化文件立刻可用。

   **部分复制** 部分复制主要是Redis针对全量复制的过高开销做出的一种优化措施， 使用psync{runId}{offset}命令实现。当从节点（slave）正在复制主节点 （master）时，如果出现网络闪断或者命令丢失等异常情况时，从节点会向 主节点要求补发丢失的命令数据，如果主节点的复制积压缓冲区内存在这部分数据则直接发送给从节点，这样就可以保持主从节点复制的一致性。 ![部分复制](https://cdn.tobebetterjavaer.com/tobebetterjavaer/images/sidebar/sanfene/redis-87600c72-cc6a-4656-81b2-e71864c97f23.png)

   1. 当主从节点之间网络出现中断时，如果超过repl-timeout时间，主节点会认为从节点故障并中断复制连接
   2. 主从连接中断期间主节点依然响应命令，但因复制连接中断命令无法发送给从节点，不过主节点内部存在的复制积压缓冲区，依然可以保存最近一段时间的写命令数据，默认最大缓存1MB。
   3. 当主从节点网络恢复后，从节点会再次连上主节点
   4. 当主从连接恢复后，由于从节点之前保存了自身已复制的偏移量和主节点的运行ID。因此会把它们当作psync参数发送给主节点，要求进行部分复制操作。
   5. 主节点接到psync命令后首先核对参数runId是否与自身一致，如果一 致，说明之前复制的是当前主节点；之后根据参数offset在自身复制积压缓冲区查找，如果偏移量之后的数据存在缓冲区中，则对从节点发送+CONTINUE响应，表示可以进行部分复制。
   6. 主节点根据偏移量把复制积压缓冲区里的数据发送给从节点，保证主从复制进入正常状态。



> 主从复制存在哪些问题？（主要是高可用和分布式两个方面）

* 一旦主节点出现故障，需要手动将一个从节点设置为主节点，同时还需要修改应用方的主节点的地址，还需要命令之前的从节点去复制新的主节点，整个过程比较麻烦，需要人工进行干预；
* 主节点的写作能力和存储能力会受到单机的限制

**那么基于以上只从复制存在的问题，我们该如何解决？！这就引入了哨兵的概念（Redis Sentinel）**

> 什么是Redis Sentinel（哨兵）？

鉴于Redis主从复制存在的一些问题就是需要人工的干预，于是Redis设计出了哨兵系统的方案，借助这个方案可以自动完成故障转移。

![Redis Sentinel](http://images.rl0206.love/202305031650481.png)





## Redis客户端

![image-20230416111339698](http://images.rl0206.love/202305021641029.png)

![image-20230416111856694](http://images.rl0206.love/202305021641030.png)

 Jedis使用的基本步骤：

1.引入依赖

2.创建Jedis对象，建立连接

3.使用Jedis，方法名与Redis命令一致

4.释放资源



1、引入依赖

```Java
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>3.7.0</version>
</dependency>
```

2、使用Jedis连接池创建连接

Jedis本身是线程不安全的，并且频繁的创建和销毁连接会有性能损耗，因此我们推荐大家使用Jedis连接池代替Jedis的直连方式。

```Java
public class JedisConnectionFactory {
   private static final JedisPool jedisPool;

   static {
     JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
     // 最大连接
     jedisPoolConfig.setMaxTotal(8);
     // 最大空闲连接
     jedisPoolConfig.setMaxIdle(8); 
     // 最小空闲连接
     jedisPoolConfig.setMinIdle(0);
     // 设置最长等待时间， ms
     jedisPoolConfig.setMaxWaitMillis(200);
     jedisPool = new JedisPool(jedisPoolConfig, "192.168.150.101", 6379,
         1000, "123321");
   }
   // 获取Jedis对象
   public static Jedis getJedis(){
     return jedisPool.getResource();
   }
 }
```

3、使用Jedis进行单元测试

```java
private Jedis jedis;
  // 单元测试的注释写法
  @BeforeEach
  void setUp() {
    // 建立连接
    jedis = JedisConnectionFactory.getJedis();
    // 设置密码
    jedis.auth("123321");
    // 选择库
    jedis.select(0);
}
  @Test
  void testString() {
    // 插入数据，方法名称就是redis命令名称，非常简单
    String result = jedis.set("name", "张三");
    System.out.println("result = " + result); 
    // 获取数据
    String name = jedis.get("name");
    System.out.println("name = " + name);
}
  @AfterEach
  void tearDown() {
    // 释放资源
    if (jedis != null) {
      jedis.close();
    }
}
```

## SpringDataRedis

> 打破Redis只接收String，接收Object类，内部通过JDK的序列化工具进行转换。（即传入一个Object对象，会将其序列化，将其“剁碎”，传入Redis，若想不剁碎，就需要重写RedisTemplate的序列化方式）

 那我们如何重写呢？

```Java

```

存：自动化将对象转JSON,

取：JSON反序列化为对象

什么原理呢？

我们会发现，在自动化转JSON时，会在JSON中第一行加入User的CLASS属性（对应的是User类的名称），所以说在反序列化的时候，会将对应的User写进来。巧妙之处就在于JSON串第一行的Class名称记录。

尽管序列化方式可以满足我们的需求，但时仍然存在问题：为了在反序列化时知道对象的类型，JSON选择将类的Class类型写入JSON结果中，存入Redis，因此导致了额外的内存开销。

那么，如何解决？如何节省内存空间？

为了节约内存空间，一般不会使用JSON序列化工具，而会使用String序列化器，但这只能存储String类型的键值对，所以我们的解决方案就是：用的到对象反序列化时，再手动创建对象的序列化和反序列化。

![image-20230419105307964](http://images.rl0206.love/202305021641031.png)

Redis序列化两种方案：

第一种：自定义Templete，修改RedisTemplete的序列化器为GenericJachson2JsonRedisSerializer；

```
public class RedisConfig{
	@Bean
	public RedisTemplete<String,Object> redisTemplete(RedisConnectionFactory connectionFactory){
		
	}
}
```

第二种：使用RedisRedisTemplete，手动序列化，读取时，手动反序列化。

