#!/bin/bash
#
# 文件名字: Part0_Global.sh
# 文件说明: 全局配置文件
# 使用说明: 把对应注释 "#" 去掉即可启用功能，按需修改或添加参数
#
# Copyright (c) 2026 ChenOSWrt
#
# 本项目为免费开源软件，遵循 MIT 开源许可证协议。
# 详细许可条款请参阅仓库内 LICENSE 文件。
#

# OpenWrt源码仓库地址
REPO_URL: https://github.com/coolsnowwolf/lede
# 源码分支
REPO_BRANCH: 20251001
# 更新日志
RELEASE_NOTES: release.txt
# 自定义前置脚本1
PART1_FEEDS: Part1_feeds.sh
# 自定义后置脚本2
PART2_CUSTOM: Part2_Custom.sh
# 是否上传完整编译bin目录
UPLOAD_BIN_DIR: false
# 是否上传编译好的固件
UPLOAD_FIRMWARE: true
# 是否发布到Releases版本
UPLOAD_RELEASE: true
# 是否启用编译缓存（ccache）
USE_CCACHE: true
# 编译缓存文件存放目录
CCACHE_DIR: $HOME/.ccache
# 设置时区为上海
TZ: Asia/Shanghai
