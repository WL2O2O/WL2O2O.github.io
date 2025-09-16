---
title: 达梦数据库
tags:
  - DM
categories:
  - Database
abbrlink: f234e628
date: 2023-08-07 08:58:32
---

# 达梦数据库

> ***INTRODUCE:***达梦数据是国内领先的数据库产品开发服务商，致力于成为国际顶尖的全栈数据产品及解决方案提供商。公司拥有核心源代码的自主知识产权，并已完成数十项国家级或省部级科研开发项目与奖项。其产品在金融、能源、航空、通信、党政机关等数十个领域得到应用，2019年至2021年公司产品市占率位居中国数据库管理系统市场国内数据库厂商前列。

## 达梦线上实验室仿真

欢迎来到达梦数据库线上实验室。

如果您是初次接触达梦数据库，我们强烈建议您加入本次线上实验室的试玩旅程。在这里，您将置身于达梦公司自主研发的新一代大型通用关系型数据库 DM8 的仿真环境中，通过 “用户权限”，“操作数据表”，“检索数据”，“创建索引”，“事务特性” 五大板块，初步体验 DM8 的基本特性。同时我们也提供了创建物化视图、存储过程等一系列“SQL 高级特性”供高级玩家探索。

**实验环境：**

操作系统：CentOS Linux release 7.3.1611 (Core)

达梦数据库实例：DM Database Server 64 V8

> ### 检查数据库版本及服务状态

**查看数据库运行状态：**

```sql
select status$ as 状态 from v$instance;
```

**运行结果：**

![](https://eco.dameng.com/tour/markdown/assets/2-1_db_status.png)

**查看数据库版本：**

```sql
select banner as 版本信息 from v$version;
```

**运行结果：**

![](https://eco.dameng.com/tour/markdown/assets/2-2_db_version.png)

> ### 创建用户并授权

* **创建用户：**

```sql
create user root identified by "123456789";
```

* **授予基本权限：**

```sql
grant resource to root;
```

* **授予用户对指定表的查询权限：**

```sql
grant select on user.employee to root;
```

* **查看用户信息：**

```sql
select username,account_status,created from dba_users where username = 'root';
```

> ### 切换用户

* **切换用户：**

```sql
conn username/password;
```

* **查看当前登录用户：**

```sql
select user from DUAL;
```

![查询当前登录用户图](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202306071107172.png)

> ### 创建表并添加约束

* **创建职员表：**

```sql
create table employee(
	employee_id INTEGER,
    employee_name vachar2(20) not null,
    hire_date DATE,
    salary INTEGER,
    department_id INTEGER NOT NULL
)
```

* **创建部门表：**

```sql
CREATE TABLE department(
  department_id INTEGER PRIMARY KEY,
  department_name VARCHAR(30) NOT NULL
);
```

* **更新表中字段可以为空：**

```sql
ALTER TABLE department MODIFY department_name VARCHAR(30);
```

* **非空约束**

```sql
ALTER TABLE employee MODIFY( hire_date not null);
```

* **主键约束**

```sql
alter table employee add constraint pk_empid primary key(employee_id);
```

* **外键约束**

```sql
alter table employee add constraint fk_dept foreign key(department_id) references department(department_id);
```

* **查看表结构**

```sql
DESC employee;
```

* **查看表的主键外键**

```sql
SELECT table_name, constraint_name, constraint_type FROM
     all_constraints WHERE owner='DM' AND table_name='EMPLOYEE';
```

> ### 验证数据表的CRUD功能

* **插入数据**

```sql
insert into department values(1,'数据库产品中心');
```

* **修改数据**

```sql
update department set department_id = 2;
```

* **提交事务**

```sql
commit;
```

* **修改数据**

```sql
update employee set salary = 20000 where employee_id = 1;
```

* **验证更新表记录能力**

```sql
SELECT salary,employee_name,employee_id FROM employee;
```

* **删除数据**

```sql
delete from employee;
delete from employee where employee_id = 1;
```

* **验证删除表数据能力**

```sql
select * from employee;
```

> ### 批量插入及选择排序

达梦数据库支持各种数据检索功能，本小节首先批量插入数据，然后验证基本的选择排序功能。

* **批量插入数据**

```sql
CREATE TABLE t1 AS
     SELECT rownum AS id,
       trunc(dbms_random.value(0, 100)) AS random_id,
       dbms_random.string('x', 20) AS random_string
     FROM dual
     connect BY level <= 100000;
```

创建一个名为 `t1` 的新表，并向其中批量插入 100,000 条随机数据。

具体地，这个 SQL 语句包含以下几个部分：

1. `CREATE TABLE t1 AS SELECT ...`：创建一个名为 `t1` 的新表，并使用 `SELECT` 语句从 `dual` 表生成数据。
2. `rownum AS id`：使用 `rownum` 函数生成一个序号列，并将其命名为 `id`。
3. `trunc(dbms_random.value(0, 100)) AS random_id`：使用 `dbms_random.value` 函数生成一个在 0 和 100 之间的随机数，并将其取整后命名为 `random_id`。
4. `dbms_random.string('x', 20) AS random_string`：使用 `dbms_random.string` 函数生成一个长度为 20 的随机字符串，并将其命名为 `random_string`。
5. `FROM dual connect BY level <= 100000`：使用 `dual` 表和 `connect by level` 语句生成 100,000 条数据。

在 `FROM` 子句中，使用 `DUAL` 表生成单行数据，然后使用 `CONNECT BY` 语法生成 100,000 行数据。在 `CONNECT BY` 子句中，使用 `LEVEL` 函数生成一个序号列，并使用 `LEVEL` 函数的值来控制生成的行数。

在 `SELECT` 子句中，使用 `dbms_random` 包中的函数生成随机数和随机字符串，并使用 `trunc` 函数对随机数取整。最后，将生成的数据插入到新表 `t1` 中。

需要注意的是，在达梦数据库中，语法和函数可能与 Oracle 数据库不同，请根据具体情况选择合适的语法和函数。

* 查看插入的数据

使用count(*) 聚集函数统计t1表中的总数据记录

```sql
SELECT COUNT(*) FROM t1;
```

* 排序数据

```sql
SELECT * FROM t1 where random_id<50 ORDER BY id DESC;
```


> 验证分组查询

* 批量插入数据

```sql
INSERT INTO department (department_id, department_name)
     SELECT department_id, department_name FROM dmhr.department;
     
INSERT INTO employee
     (employee_id, employee_name, hire_date, salary, department_id)
     SELECT employee_id, employee_name, hire_date, salary,
     department_id FROM dmhr.employee;
     
commit;
```

* 分组查询

```sql
SELECT dept.department_name as 部门, count(*) as 人数
     FROM employee emp, department dept
     where emp.department_id=dept.department_id
     GROUP BY dept.department_name
     HAVING count(*) > 20;
```

> 创建视图

达梦数据库支持标准的视图功能，本小节将验证其对标准视图的支持能力。

* 定义视图

需要查询薪资大于 10000 且入职时间大于等于 2013 年 8 月 1 日 员工的部门名称、姓名、薪资、入职时间。

```sql
CREATE OR replace VIEW v1 AS
     SELECT dept.department_name, emp.employee_name,
     emp.salary,emp.hire_date
     FROM employee emp, department dept
     WHERE salary > 10000
     AND hire_date >= '2013-08-01'
     AND emp.department_id = dept.department_id;
```

**视图的作用：**

它的作用是从 employee 和 department 两个表中筛选出满足一定条件的记录，并将它们合并成一个结果集。具体来说，这个视图包含了四个字段，分别是：

- department_name：部门名称，来自 department 表；
- employee_name：员工姓名，来自 employee 表；
- salary：员工薪水，来自 employee 表；
- hire_date：员工入职日期，来自 employee 表。

通过这个视图，我们就可以方便地查询所有**符合以上三个条件的员工的信息**，包括他们所在的部门、姓名、薪水和入职日期。视图可以看做是一个虚拟的表格，它不存储任何数据，而是通过查询操作来获取数据的。因此，我们可以像查询普通表格一样来查询这个视图，而不用关心它是如何生成的。

* 通过视图简化查询符合多个条件的数据

```sql
SELECT * FROM v1 WHERE hire_date > '2014-09-01';
```

> 创建索引

验证达梦数据库如何创建及删除索引，并通过索引提升查询效率。

创建普通索引

```sql
create index ind_emp_salary on employee(salary);
```





> 事务

以下是常用的达梦数据库事务相关语句：

​	1.开始事务：`START TRANSACTION` 或者 `BEGIN TRANSACTION`

```
START TRANSACTION;
-- 事务执行的 SQL 语句
COMMIT;
```

​	2.回滚事务：`ROLLBACK`

```
START TRANSACTION;
-- 事务执行的 SQL 语句
ROLLBACK;
```

​	3.提交事务：`COMMIT`

```
START TRANSACTION;
-- 事务执行的 SQL 语句
COMMIT;
```

​	4.设置事务隔离级别：`SET TRANSACTION ISOLATION LEVEL`

```
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

​	5.保存点：`SAVEPOINT` 和 `ROLLBACK TO SAVEPOINT`

```
START TRANSACTION;
-- 事务执行的 SQL 语句
SAVEPOINT my_savepoint;
-- 更多 SQL 语句
ROLLBACK TO SAVEPOINT my_savepoint;
-- 更多 SQL 语句
COMMIT;
```

​	6.设置事务的名称：`SAVEPOINT`

```
SAVEPOINT my_savepoint;
-- 更多 SQL 语句
ROLLBACK TO my_savepoint;
-- 更多 SQL 语句
COMMIT;
```

以上是常用的达梦数据库事务相关语句，您可以根据实际需求选择使用。请注意，在使用事务时，还需要注意锁定和事务隔离级别等问题，以避免出现并发问题和数据不一致的情况。

待补充... ...