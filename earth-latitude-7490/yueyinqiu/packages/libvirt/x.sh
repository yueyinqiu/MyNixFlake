#!/usr/bin/env bash

# 遇到错误立即退出
set -e

# 1. 检查参数数量是否正确
if [ "$#" -ne 2 ]; then
    echo "错误: 参数输入不正确！"
    echo "用法: $0 <镜像路径.qcow2> <镜像大小>"
    echo "示例: $0 ~/VirtualMachines/win11/storage.qcow2 128G"
    exit 1
fi

TARGET_FILE="$1"
IMG_SIZE="$2"

# 2. 检查目标文件是否已经存在，防止误覆盖
if [ -e "$TARGET_FILE" ]; then
    echo "错误: 文件 '$TARGET_FILE' 已经存在！"
    echo "为了防止数据丢失，脚本已安全退出。请指定一个新的文件名。"
    exit 1
fi

# 3. 确保目标文件所在的父目录存在
TARGET_DIR=$(dirname "$TARGET_FILE")
if [ ! -d "$TARGET_DIR" ]; then
    echo "提示: 目标目录 '$TARGET_DIR' 不存在，正在为你创建..."
    mkdir -p "$TARGET_DIR"
fi

echo "正在创建干净的 NOCOW 虚拟磁盘，请稍候..."

# 4. 创建 0 字节文件占位
touch "$TARGET_FILE"

# 5. 立即赋予 NOCOW 属性 (+C)
if ! chattr +C "$TARGET_FILE" 2>/dev/null; then
    # 如果不是 root 用户，有些系统可能需要 sudo，或者文件系统不支持
    echo "警告: 无法直接设置 +C 属性，尝试使用 sudo..."
    sudo chattr +C "$TARGET_FILE"
fi

# 6. 生成虚拟机镜像
# 注意：使用 -n (noclobber) 参数告诉 qemu-img 不要完全抹掉文件，而是往已有属性的空文件里写入数据
if qemu-img create -f qcow2 -n "$TARGET_FILE" "$IMG_SIZE"; then
    echo "==========================================="
    echo "✓ 虚拟机镜像创建成功！"
    echo "路径: $TARGET_FILE"
    echo "大小: $IMG_SIZE"
    echo "属性: 已成功开启 NOCOW，无需担心 Btrfs 碎片化。"
    echo "==========================================="
else
    echo "错误: qemu-img 创建镜像失败！"
    # 如果失败了，把占位用的空文件删掉，保持干净
    rm -f "$TARGET_FILE"
    exit 1
fi