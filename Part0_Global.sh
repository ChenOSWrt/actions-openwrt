#!/bin/bash
# 全局统一配置文件
# 以后只改这里！YML 自动同步！

REPO_URL="https://github.com/coolsnowwolf/lede"
REPO_BRANCH="20251001"
RELEASE_NOTES="release.txt"
PART1_FEEDS="Part1_feeds.sh"
PART2_CUSTOM="Part2_Custom.sh"
UPLOAD_BIN_DIR="false"
UPLOAD_FIRMWARE="true"
UPLOAD_RELEASE="true"
USE_CCACHE="true"
CCACHE_DIR="$HOME/.ccache"
TZ="Asia/Shanghai"
