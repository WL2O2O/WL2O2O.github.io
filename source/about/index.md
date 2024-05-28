---
title: 关于本站
layout: about
date: 2023-08-19 18:13:14
---

> **I would appreciate it if you think my resume is good and have a hiring need, please feel free to contact me!**
# Resume
{% note info %}
**CSGUIDER - Java开发**

📱166 3840 6024 &nbsp;📬<u>[csguider@163.com](mailto:csguider@163.com)</u>&nbsp;🧑‍💻<u>[wl2o2o.github.io](https://wl2o2o.github.io)</u>(UV: 2.2K+/PV: 4K+)&nbsp;🤝<u>[github.com/wl2o2o](https://github.com/wl2o2o)</u>
{% endnote %}

{% note success %}

**专业技能**

<div style="height: 0.5px; background-color: #000000;"></div>

- Java基础：Java基础扎实，如集合类、Java 安全管理器、进程类、编译执行原理、部分 JDK 源码

- JVM：熟悉 JVM 的相关知识，比如类加载机制、对象创建过程、垃圾回收算法、部分 JVM 参数 
- JUC：熟悉Java并发编程，包括 ThreadLocal、Java 内存模型、锁、线程池、并发工具类等
- 框架：熟练使用 Spring Boot、Spring、Spring MVC、MyBatis、MyBatis-Plus 等常用技术框架 
- MySQL：熟练使用 MySQL、熟悉 MySQL 的存储引擎、索引、锁、事务、以及高可用和性能优化 
- Redis：熟悉 Redis 底层数据结构、持久化、缓存设计以及 Redis 应用，比如异步队列与延时队列 
- RabbitMQ：熟悉 RabbitMQ 消息队列，有过手动消息确认、应用解耦、消息生产消费的实践
- 设计模式：熟悉并实践过多种设计模式，比如策略模式、工厂模式、模板方法模式、代理模式 
- Docker：实践过 Docker 技术，能够熟练运用命令行和 Docker Java 库两种方式操作 Docker 
- 工具：熟练掌握 Git 、Maven 构建工具、mvnw 构建工具以及 nvm 版本管理器的使用

{% endnote %}

{% note danger %}

**实习经历**

<div style="height: 0.5px; background-color: #000000;"></div>

<div style="display: flex; justify-content: space-between; width: 100%; padding: 10px;">
    <span style="display: inline-block; margin: 0;">浙江网新恒天软件有限公司</span>
    <span style="display: inline-block; margin: 0;">后端开发实习生</span>
    <span style="display: inline-block; margin: 0;">2023.06~2023.09</span>
</div>

- 从事 Java 程序相关开发工作； 
- 负责软件项目、模块的需求分析、设计、编码实现、验证； 
- 参与相关质量活动，确保软件设计及实现工作按时保质完成。

{% endnote %}

{% note primary %}

**项目经验**

<div style="height: 0.5px; background-color: #000000;"></div>

<div style="display: flex; justify-content: space-between; width: 100%; padding: 10px;">
    <span style="display: inline-block; margin: 0;">
        <p style="font-weight: bold; left: 0;">
            SmartOJ 在线编程判题系统
            <a href="https://github.com/WL2O2O/smartoj-backend-microservice" target="_blank">🔗<u><i>Link</i></u></a>
        </p>
    </span>
    <span style="display: inline-block; margin: 0;">2023.09~2023.12</span>
</div>


&nbsp;&nbsp;`Spring Cloud`  `RabbittMQ`  `Docker`  `Vue`  `Arco Design`
- 项目描述
  - 基于 Spring Cloud Alibaba **微服务架构** 的编程题目评测系统。系统能够根据管理员预设的题目用例对用
    户提交的代码进行执行和评测；系统中 **自主实现的代码沙箱** 可作为独立服务供其他开发者调用。
- 实现功能
  - 根据业务流程自主设计用户表、题目表、题目提交表，并通过给题目表添加 userId 索引提升检索性能； 
  - **系统架构**：根据功能职责，将系统划分为负责核心业务的后端模块、负责校验结果的判题模块、负责编译执行代码的**可复用代码沙箱**。各模块相互独立，并通过 API 接口和分包的方式实现协作； 
  - 自主设计判题机模块的架构，定义了代码沙箱的抽象调用接口和多种实现类（比如远程 / 第三方代码沙箱），并通过 **静态工厂模式 + Spring 配置化** 的方式实现了对多种代码沙箱的灵活调用；
  - 使用 **代理模式** 增强代码沙箱接口能力，统一实现了对代码沙箱调用前后的日志记录，减少重复代码； 使用 Java Runtime 对象的 exec 方法实现了对 Java 程序的编译和执行，并通过 **Process** 类 的输入流获取执行结果，实现了 Java 原生代码沙箱，跑通了整个流程；
  - 使用 **Java 安全管理器**和自定义的 **Security Manager** 对用户提交的代码进行权限控制，比如关闭写文件、执行文件权限，进一步提升了代码沙箱的安全性； 
  - 通过编写脚本自测代码沙箱，模拟了多种程序异常情况并针对性解决，如使用**守护线程** + Thread.sleep 等待机制实现了对进程的超时中断、使用 黑白名单 + **字典树** 的方式实现了对敏感操作的限制； 
  - 为保证沙箱宿主机的稳定性，选用 Docker 隔离用户代码，使用 **Docker Java** 库创建容器隔离执行代码，并通过 tty 和 Docker 进行传参交互，从而实现了更安全的代码沙箱。

<div style="display: flex; justify-content: space-between; width: 100%; padding: 10px;">
    <span style="display: inline-block; margin: 0;">
        <p style="font-weight: bold; left: 0;">
            SmartAPI 开放平台
            <a href="https://github.com/WL2O2O/smartapi-backend" target="_blank">🔗<u><i>Link</i></u></a>
        </p>
    </span>
    <span style="display: inline-block; margin: 0;">2023.06~2023.8</span>
</div>

- 项目描述
  - API 接口开放调用平台。管理员可以接入并发布接口，可视化各接口调用情况；用户可以开通接口调用权限、浏览接口及在线调试，并通过客户端 SDK 轻松调用接口。
- 实现功能
  - 使用 Ant Design Pro 脚手架 + 自建 Spring Boot 模板构建项目，实现统一鉴权、多环境切换基础功能； 
  - 基于 MyBatis-Plus 框架的 QueryWrapper 实现对 MySQL 数据库的灵活查询，并配合 MyBatis X 插件自动生成后端 CRUD 基础代码，减少重复工作；
  - 为防止接口被非法用户恶意调用，设计了 API 签名认证算法，通过为用户分配唯一的 accessKey 和 secretKey 用以鉴权，保障了调用的安全性、可溯源性（指便于统计接口调用次数）；
  - 为解决开发者调用成本过高的问题（须自己使用 HTTP + 封装签名去调用接口，平均 20 行左右代码）， 基于 Spring Boot Starter 开发了客户端SDK，实现一行代码调用接口，提高了开发体验； 
  - 为解决多个子系统内代码大量重复的问题，抽象模型层和业务层代码为公共模块，并使用 Dubbo RPC 框架实现子系统间的高性能接口调用，大幅减少重复代码；
  - 自主编写 Dockerfile ，通过第三方容器托管平台实现自动化镜像构建以及容器创建，提高部署上线效率


<div style="display: flex; justify-content: space-between; width: 100%; padding: 10px;">
    <span style="display: inline-block; margin: 0;">
        <p style="font-weight: bold; left: 0;">
            校园失物招领系统
            <a href="https://gitee.com/WLei224/CampusLostAndFound" target="_blank">🔗<u><i>Link</i></u></a>
        </p>
    </span>
    <span style="display: inline-block; margin: 0;">2023.03~2023.4</span>
</div>

&nbsp;&nbsp;`JSP`   `SSM`   `WebSocket`  `synchronized`  `ConcurrentHashMap`
- 项目描述
  - 基于 SSM 框架设计的校园失物招领聊天交流系统，使用了 WebSocket 实现了实时聊天功能。用户可以登录与注册、发布失物或招领信息、发布感谢信，管理员可以对用户、相关信息进行管理。
- 实现功能
  - 采用并发控制，用 synchronized 和ConcurrentHashMap，确保高并发访问下的数据安全和一致性；
  - 使用 WebSocket 实现实时聊天功能，避免频繁HTTP请求对服务器的压力，优化了系统并发处理能力； 
  - 对于聊天室权限管理等功能，采用了分布式锁等技术，提高了系统的并发处理能力和可扩展性； 
  - 通过优化数据库设计和查询语句，提高了系统处理高并发请求的能力。


<div style="display: flex; justify-content: space-between; width: 100%; padding: 10px;">
    <span style="display: inline-block; margin: 0;">
        <p style="font-weight: bold; left: 0;">
            医院预约挂号平台
        </p>
    </span>
    <span style="display: inline-block; margin: 0;">2022.10~2022.12</span>
</div>

&nbsp;&nbsp;`Vue`   `SpringBoot`  `Spring Cloud`   `MongoDB`   `Redis`   `RabbitMQ`   `GateWay`
- 项目描述
  - 基于微服务架构的问诊预约系统，用户可以微信单点登录、预约挂号、支付订单，管理员可以会员管理、订单管理、统计管理以及对数据字典的导入导出
- 实现功能
  - 基于 Spring Cloud + Nacos 实现项目的微服务化，划分项目服务模块，提高项目的可扩展性和容错性；
  - 使用 JWT 实现单点登录，并支持手机验证码、OAuth2 微信扫码登录，提高用户真实性和登录安全性； 
  - 使用 Nuxt 框架实现服务端渲染，提高网页首屏加载速度（10秒到5秒）；
  - 使用 Spring Cloud Gateway 实现微服务请求转发，并在网关层全局解决跨域、用户鉴权、黑白名单、内网服务保护等问题，降低了开发成本、大幅度提高了系统的安全性。

{% endnote %}


------


### 我的博客之路

{% note secondary %}
20年入学时，便发表了我的第一篇博客，还是关于C语言的，还清楚的记得当时给自己定的目标：从小白到精通，然后贴了一张`helloworld`的运行截图，哈哈哈哈，大概`helloworld`就是每个程序员梦开始的地方吧！慢慢的，开始看一些计算机领域的技术性文章。开始观摩别人的优秀文章的写作风格，然后发表自己的文章，随笔、博客、以及杂谈。最近我最大的感受就是，做任何事情都是有风口浪尖的，这句话可谓是屡试不爽。抓住机遇很重要！抓住机遇很重要！抓住机遇！
{% endnote %}

{% note success %}
`21`年在家人的推荐下，开始摸索搭建自己的`hexo`博客，刚开始是一点都不懂的是什么，总是自以为是，就开始一步一步照着教程开始搭建，其实这样的逻辑并不好，我们做一件事情之前，首先应该经过充分的了解，也就是知己知彼百战不殆这个道理。果不其然搭建过程中碰到了很多问题，也印证了一句话：自己的人生都是一步一个脚印走出来的，我们总是喜欢在失败中成长。一次次干掉重新搭建，最终也算是基本搭建好了，然后就放着没有怎么完善了。
{% endnote %}

{% note danger %}
`22`年年底，接触到了沉默王二（二哥）和程序员鱼皮、guide哥等CS领域的大V，受到二哥Java程序员进阶之路和知识星球的的启发与鼓舞，心想怎么会有这么完善的小网站，CS领域的学生看到后，谁看谁不迷糊？于是我也想搭建一个自己的基于`vuepress`的个人博客，加上自己有搭建`hexo博客`的经验，搭建起来还是很顺利的，上手很快，目前模块功能正在逐步完善中~，越整越花里胡哨，最后感觉还是喜欢简约风，`vuepress`网站就暂时当作一个小型知识库了。此时的我已经马上大三了，些许迷茫，最后选择了`Java`这条路子。
{% endnote %}

{% note warning %}
`23`年......
{% endnote %}

{% label danger @最后，与你共勉：优秀的人总有他优秀的原因！一起加油吧！ %}
