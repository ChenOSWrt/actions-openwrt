#!/bin/bash
set -euo pipefail

VERSION_PREFIX="${VERSION_PREFIX:-v1.1}"
RELEASE_TAG="${RELEASE_TAG:-${VERSION_PREFIX}.${GITHUB_RUN_NUMBER}}"

echo "release_tag=${RELEASE_TAG}" >> "$GITHUB_OUTPUT"
echo "status=success" >> "$GITHUB_OUTPUT"

echo "============================================="
echo "发布核心固件到Release"
echo "版本标签：$RELEASE_TAG"
echo "固件目录：$FIRMWARE"
echo "说明文件：$RELEASE_NOTES"
echo "============================================="

if ! gh release view "$RELEASE_TAG" >/dev/null 2>&1; then
  echo -e "\n创建新 Release ..."
  gh release create "$RELEASE_TAG" \
    --title "$RELEASE_TAG" \
    --notes-file "$RELEASE_NOTES"
else
  echo -e "\n✅ Release 已存在，跳过创建"
fi

echo -e "\n上传核心固件中 ..."
gh release upload "$RELEASE_TAG" \
  "${FIRMWARE}"/* \
  --clobber

echo -e "\n✅ 核心固件上传完成！"
