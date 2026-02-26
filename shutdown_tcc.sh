#!/bin/bash

# 定义相关端口
PORTS=(12332 22332 8081 8082 8083)

echo "--- 正在停止 TCC 相关进程 ---"

# 1. 根据端口停止进程
for port in "${PORTS[@]}"; do
    pid=$(lsof -ti:$port)
    if [ ! -z "$pid" ]; then
        echo "发现端口 $port 被进程 $pid 占用，正在停止..."
        kill $pid
        sleep 1
        # 检查是否还在运行，如果是则强制杀死
        if ps -p $pid > /dev/null; then
            echo "进程 $pid 未能正常停止，正在强制杀死..."
            kill -9 $pid
        fi
    fi
done

# 2. 根据名称进行清理（补漏）
echo "清理可能残留的 TCC 进程..."
pkill -f tcc-transaction-server || true
pkill -f tcc-transaction-dashboard || true
pkill -f tcc-transaction-http || true

echo "--- 停止操作已完成 ---"
