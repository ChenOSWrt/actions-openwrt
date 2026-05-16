#!/bin/bash
set -euo pipefail

# ===================== 配置项（从环境变量读取，无需改脚本） =====================
# 必须环境变量：
# GITHUB_TOKEN      GitHub 令牌
# GITHUB_RUN_NUMBER Actions 运行号（自动生成版本号用）
# FIRMWARE          固件文件目录
# RELEASE_NOTES     发布说明文件路径

# 可选配置（默认值）
VERSION_PREFIX="${VERSION_PREFIX:-v1.1}"
RELEASE_TAG="${RELEASE_TAG:-${VERSION_PREFIX}.${GITHUB_RUN_NUMBER}}"

# ===================== 输出版本号（给 GitHub Actions 后续步骤使用） =====================
echo "release_tag=${RELEASE_TAG}" >> "$GITHUB_OUTPUT"
echo "status=success" >> "$GITHUB_OUTPUT"

echo "============================================="
echo "📦 发布 Release 到 GitHub"
echo "🏷  版本标签：$RELEASE_TAG"
echo "📁 固件目录：$FIRMWARE"
echo "📄 说明文件：$RELEASE_NOTES"
echo "============================================="

# ===================== 1. 如果 Release 不存在则创建 =====================
if ! gh release view "$RELEASE_TAG" >/dev/null 2>&1; then
  echo -e "\n🆕 创建新 Release ..."
  gh release create "$RELEASE_TAG" \
    --title "$RELEASE_TAG" \
    --notes-file "$RELEASE_NOTES"
else
  echo -e "\n✅ Release 已存在，跳过创建"
fi

# ===================== 2. 上传固件（覆盖已存在文件） =====================
echo -e "\n🚀 上传固件文件 ..."
gh release upload "$RELEASE_TAG" \
  "${FIRMWARE}"/* \
  --clobber

echo -e "\n✅ Release 发布 & 上传完成！"
