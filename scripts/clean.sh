#!/bin/bash
set -euo pipefail

# 读取参数
KEEP_LATEST="${KEEP_LATEST:-3}"
KEEP_DAYS="${KEEP_DAYS:-7}"

# ===================== 清理 Workflow 运行记录 =====================
if [[ "${CLEAN_TYPE:-}" == "run" ]]; then
  echo "============================================="
  echo "🧹 清理 GitHub Actions 旧运行记录"
  echo "保留最新条数：$KEEP_LATEST"
  echo "保留最近天数：$KEEP_DAYS 天"
  echo "============================================="

  echo -e "\n📅 清理超时记录..."
  gh run list --workflow "$GITHUB_WORKFLOW" --limit all --json databaseId,createdAt -q '.[] | [.databaseId, .createdAt] | @tsv' | while read -r id createdAt; do
    [ -z "$id" ] && continue
    if [[ $(date -d "$createdAt" +%s) -lt $(date -d "-${KEEP_DAYS} days" +%s) ]]; then
      echo "删除记录：$id"
      gh run delete "$id" || echo "⚠️ 删除失败，跳过"
    fi
  done

  echo -e "\n🔢 清理超量记录..."
  gh run list --workflow "$GITHUB_WORKFLOW" --limit all --json databaseId -q ".[${KEEP_LATEST}:][] | .databaseId" | while read -r id; do
    [ -n "$id" ] || continue
    echo "删除记录：$id"
    gh run delete "$id" || echo "⚠️ 删除失败，跳过"
  done

  echo -e "\n✅ Workflow 清理完成！"
fi

# ===================== 清理 Releases & Tags =====================
if [[ "${CLEAN_TYPE:-}" == "release" ]]; then
  echo "============================================="
  echo "🏷️ 清理旧 Release & Tag"
  echo "保留最新版本：$KEEP_LATEST"
  echo "保留最近天数：$KEEP_DAYS 天"
  echo "============================================="

  echo -e "\n📅 清理超时版本..."
  gh release list --json tagName,publishedAt -q '.[] | [.tagName, .publishedAt] | @tsv' | while read -r tag pubTime; do
    [ -z "$tag" ] && continue
    if [[ $(date -d "$pubTime" +%s) -lt $(date -d "-${KEEP_DAYS} days" +%s) ]]; then
      echo "删除版本：$tag"
      gh release delete "$tag" --yes || true
      git push origin --delete "$tag" || true
    fi
  done

  echo -e "\n🔢 清理超量版本..."
  gh release list --json tagName -q ".[${KEEP_LATEST}:][] | .tagName" | while read -r tag; do
    [ -z "$tag" ] && continue
    echo "删除版本：$tag"
    gh release delete "$tag" --yes || true
    git push origin --delete "$tag" || true
  done

  echo -e "\n✅ Release 清理完成！"
fi
