#!/bin/bash

# 定义相关端口
PORTS=(12332 22332 8081 8082 8083)

echo "--- 正在清理旧的 TCC 进程 ---"

# 1. 根据端口强杀进程 (最有效)
for port in "${PORTS[@]}"; do
    pid=$(lsof -ti:$port)
    if [ ! -z "$pid" ]; then
        echo "发现端口 $port 被进程 $pid 占用，正在强制杀死..."
        kill -9 $pid
    fi
done

# 2. 根据名称兜底清理
pkill -9 -f tcc-transaction-server || true
pkill -9 -f tcc-transaction-dashboard || true
pkill -9 -f tcc-transaction-http || true

echo "等待 2 秒确保资源释放..."
sleep 2

echo "--- 正在按顺序启动服务 ---"

# 启动 Server
echo "[1/5] 启动 Server (12332)..."
nohup java -Drevision=2.1.0 -jar /Users/chaka/github/tcc-transaction/tcc-transaction-server/target/tcc-transaction-server-exec.jar > /Users/chaka/github/tcc-transaction/server.log 2>&1 &
sleep 8

# 启动 Dashboard
echo "[2/5] 启动 Dashboard (22332)..."
nohup java -Drevision=2.1.0 -jar /Users/chaka/github/tcc-transaction/tcc-transaction-dashboard/target/tcc-transaction-dashboard-exec.jar --server.port=22332 > /Users/chaka/github/tcc-transaction/dashboard.log 2>&1 &
sleep 8

# 启动 Capital
echo "[3/5] 启动 Capital (8082)..."
nohup java -Drevision=2.1.0 -jar /Users/chaka/github/tcc-transaction/tcc-transaction-tutorial-sample/tcc-transaction-http-sample/tcc-transaction-http-capital/target/tcc-transaction-http-capital-2.1.0.jar > /Users/chaka/github/tcc-transaction/capital.log 2>&1 &

# 启动 Redpacket
echo "[4/5] 启动 Redpacket (8083)..."
nohup java -Drevision=2.1.0 -jar /Users/chaka/github/tcc-transaction/tcc-transaction-tutorial-sample/tcc-transaction-http-sample/tcc-transaction-http-redpacket/target/tcc-transaction-http-redpacket-2.1.0.jar > /Users/chaka/github/tcc-transaction/redpacket.log 2>&1 &

# 启动 Order
echo "[5/5] 启动 Order (8081)..."
nohup java -Drevision=2.1.0 -jar /Users/chaka/github/tcc-transaction/tcc-transaction-tutorial-sample/tcc-transaction-http-sample/tcc-transaction-http-order/target/tcc-transaction-http-order-2.1.0.jar > /Users/chaka/github/tcc-transaction/order.log 2>&1 &

echo "--- 启动指令已全部发出 ---"
echo "请使用 'tail -f server.log' 查看启动进度。"
