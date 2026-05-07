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

# 清空原有软件源配置（彻底清空）
> feeds.conf.default

# LEDE
echo 'src-git packages https://github.com/coolsnowwolf/packages' >>feeds.conf.default
echo 'src-git luci https://github.com/coolsnowwolf/luci.git;openwrt-23.05' >>feeds.conf.default
echo 'src-git routing https://github.com/coolsnowwolf/routing' >>feeds.conf.default
echo 'src-git telephony https://github.com/coolsnowwolf/telephony.git' >>feeds.conf.default

# 开启 helloworld 插件源（科学上网）
# echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default
