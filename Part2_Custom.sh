#!/bin/bash
source $GITHUB_WORKSPACE/Part0_Global.sh
#
# 文件名字: Part2_Custom.sh
# 文件说明: 固件自定义配置脚本 (更新软件源之后执行)
# 使用说明: 使用说明: 把对应注释 "#" 去掉即可启用功能，按需修改或添加参数
#
# Copyright (c) 2026 ChenOSWrt
#
# 本项目为免费开源软件，遵循 MIT 开源许可证协议。
# 详细许可条款请参阅仓库内 LICENSE 文件。
#

# 修改路由器默认主机名（设备名称）
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 修改路由器默认管理IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
