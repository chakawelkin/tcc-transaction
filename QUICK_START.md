# TCC-TRANSACTION 快速入门指南

本文档将指引你如何快速启动 `tcc-transaction` 项目并运行演示示例 (Tutorial Sample)。

## 1. 环境要求

- **JDK**: 1.8+
- **Maven**: 3.5+
- **MySQL**: 5.7+ (用于持久化事务日志和业务数据)
- **Redis** (可选): 可作为高性能事务日志存储介质

## 2. 数据库初始化

`tcc-transaction` 需要初始化事务日志库和示例业务库。脚本位于以下路径：

### 2.1 初始化基础库
- **事务引擎核心表**: `tcc-transaction-core/src/main/dbscripts/db.sql` (存放事务日志)
- **Server 运行库**: `tcc-transaction-server/src/main/dbscripts/db_init.sql`

### 2.2 初始化示例 (Tutorial Sample) 业务库
执行 `tcc-transaction-tutorial-sample/src/dbscripts/` 下的 SQL 脚本：
- `create_db_tcc.sql`: 示例使用的 TCC 事务日志库。
- `create_db_ord.sql`: 订单业务库。
- `create_db_cap.sql`: 资金业务库。
- `create_db_red.sql`: 红包业务库。

> **注意**: 请根据你的 MySQL 环境修改脚本中的连接配置或手动在对应数据库执行。

## 3. 编译项目

在项目根目录下执行 Maven 命令，将项目编译并安装到本地仓库：

```bash
mvn clean install -DskipTests
```

## 4. 运行快速启动脚本

项目根目录下提供了一键启动脚本 `start_tcc.sh`，它会按顺序启动以下组件：
1. **TCC Server**: 核心事务引擎。
2. **Dashboard**: 事务管理控制台。
3. **Tutorial Samples**: 包含 Capital (资金), Redpacket (红包), Order (订单) 三个微服务。

执行启动命令：
```bash
chmod +x start_tcc.sh
./start_tcc.sh
```

可以通过查看日志文件观察启动进度：
- `server.log`
- `dashboard.log`
- `order.log` / `capital.log` / `redpacket.log`

## 5. 验证运行

### 5.1 事务控制台 (Dashboard)
启动成功后，访问控制台：
- **URL**: [http://localhost:22332](http://localhost:22332)
- 在控制台中你可以查看当前活动的事务信息。

### 5.2 模拟业务下单
你可以通过调用 `Order` 服务的接口来触发一个分布式事务：
- **接口**: 访问订单服务的下单页面或通过 Postman 模拟。
- 默认 Order 服务端口为 `8081`。

## 6. 如何接入你的项目

1. **引入依赖**: 在你的 `pom.xml` 中引入 `tcc-transaction-spring-boot-starter`。
2. **配置**: 在 `application.yml` 中配置事务存储方式（MySQL/Redis）及 Server 地址。
3. **声明 TCC**: 在业务方法上添加 `@Compensable` 注解，并实现对应的 `confirm` 和 `cancel` 方法。

更多详细配置请参考官方文档：[https://changmingxie.github.io](https://changmingxie.github.io)
