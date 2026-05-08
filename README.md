
# Actions-OpenWrt

基于 GitHub Actions 自动编译 OpenWrt 的模板

## 使用方法

- 右上角点击 Fork;
- 在 Repository name 栏目中填写你的自定义仓库名(其他不用改)，然后点 Create repository;
- 在 .github/workflows/*-builder.yml 中可改源码仓库地址和源码分支;
- 借助 Lean 或 immortalwrt 源码生成 .config 配置文件;
- 在 Actions 页面选择 Build OpenWrt 编译任务;
- 点击 Run workflow 按钮;
- 编译完成后，点击 Actions 页面底部下载完整的固件镜像

## 温馨提示

- 生成配置文件及编译 OpenWrt 固件耗时通常较长。因此，在新建仓库自行编译固件前，可先在 GitHub 搜索
  Actions-Openwrt，查看是否已有他人编译好、符合你需求的固件版本。
- 请在仓库简介中补充固件相关信息（如固件架构、预装软件包等），方便他人查阅，节省他人时间。

## 致谢 / 项目引用

- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)
- [immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)
- [actions/checkout](https://github.com/actions/checkout)
- [actions/upload-artifact](https://github.com/actions/upload-artifact)
- [actions/cache](https://github.com/actions/cache)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [Mattraks/delete-workflow-runs](https://github.com/Mattraks/delete-workflow-runs)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)          
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
