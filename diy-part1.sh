#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt 自定义脚本 第一部分 (更新软件源之前执行)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 取消注释一个软件源（取消 feeds.conf.default 中 helloworld 源的注释）
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 添加一个软件源
# 向 feeds.conf.default 文件中追加 helloworld 软件源地址
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
