# TCC-TRANSACTION

> **致敬原作者**：本项目 Fork 自 [changmingxie/tcc-transaction](https://github.com/changmingxie/tcc-transaction)。感谢作者 **Changming Xie** 提供的优秀分布式事务解决方案。

## TCC-TRANSACTION是什么

[TCC-TRANSACTION](https://changmingxie.github.io)是一款开源的微服务架构下的TCC型分布式事务解决方案，致力于提供高性能和简单易用的分布式事务服务。

- Try: 尝试执行业务，完成所有业务检查（一致性），预留必须业务资源（准隔离性）
- Confirm: 确认执行业务，不作任何业务检查，只使用Try阶段预留的业务资源，满足幂等性
- Cancel: 取消执行业务，释放Try阶段预留的业务资源，满足幂等性