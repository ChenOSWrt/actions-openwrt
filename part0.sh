#!/bin/bash
# part0.sh —— 全局变量配置脚本
# 以后只改这里，yml 永远不动

# OpenWrt 源码
export REPO_URL="https://github.com/coolsnowwolf/lede"
export REPO_BRANCH="20251001"

# 脚本文件
export RELEASE_NOTES="release.txt"
export PART1_FEEDS="Part1_Feeds.sh"
export PART2_CUSTOM="Part2_Custom.sh"

# 编译开关
export UPLOAD_BIN_DIR="false"
export UPLOAD_FIRMWARE="false"
export UPLOAD_RELEASE="true"
export USE_CCACHE="false"

# 路径 & 时区
export CCACHE_DIR="/home/runner/.ccache"
export TZ="Asia/Shanghai"
