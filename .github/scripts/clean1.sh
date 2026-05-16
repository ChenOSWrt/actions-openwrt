
#!/bin/bash
set -euo pipefail

# 通用默认参数
KEEP_LATEST="${KEEP_LATEST:-3}"
KEEP_DAYS="${KEEP_DAYS:-7}"
# 测试模式 true=只打印不删除  false=真实删除
DRY_RUN="${DRY_RUN:-false}"

if [ "$DRY_RUN" = "true" ]; then
    echo "🧪 运行在【测试预览模式】，仅列出待删除项，不会真实删除"
else
    echo "🚀 运行在【正式执行模式】，将真实清理数据"
fi

# ===================== 1. 清理Workflow运行记录 =====================
if [[ "${CLEAN_TYPE}" == "run" ]]; then
  echo "============================================="
  echo "🧹 清理GitHub Actions运行记录"
  echo "保留最新条数：$KEEP_LATEST"
  echo "保留最近天数：$KEEP_DAYS 天"
  echo "============================================="

  echo -e "\n📅 开始筛选超时旧记录..."
  gh run list --workflow "$GITHUB_WORKFLOW" --limit all --json databaseId,createdAt -q '.[] | [.databaseId, .createdAt] | @tsv' | while read -r id createdAt; do
    [ -z "$id" ] && continue
    if [[ $(date -d "$createdAt" +%s) -lt $(date -d "-${KEEP_DAYS} days" +%s) ]]; then
      echo "🗑️ 待删除运行记录ID：$id"
      [ "$DRY_RUN" != "true" ] && gh run delete "$id" || echo "⚠️ 删除失败跳过"
    fi
  done

  echo -e "\n🔢 开始筛选超出保留条数的旧记录..."
  gh run list --workflow "$GITHUB_WORKFLOW" --limit all --json databaseId -q ".[${KEEP_LATEST}:][] | .databaseId" | while read -r id; do
    [ -n "$id" ] || continue
    echo "🗑️ 待删除运行记录ID：$id"
    [ "$DRY_RUN" != "true" ] && gh run delete "$id" || echo "⚠️ 删除失败跳过"
  done

  echo -e "\n✅ 运行记录清理流程执行完毕"
fi

# ===================== 2. 清理Releases与Tags =====================
if [[ "${CLEAN_TYPE}" == "release" ]]; then
  echo "============================================="
  echo "🏷️ 清理旧Release版本与对应Tag"
  echo "保留最新版本数：$KEEP_LATEST"
  echo "保留最近天数：$KEEP_DAYS 天"
  echo "============================================="

  echo -e "\n📅 开始筛选超时版本..."
  gh release list --json tagName,publishedAt -q '.[] | [.tagName, .publishedAt] | @tsv' | while read -r tag pubTime; do
    [ -z "$tag" ] && continue
    if [[ $(date -d "$pubTime" +%s) -lt $(date -d "-${KEEP_DAYS} days" +%s) ]]; then
      echo "🗑️ 待删除版本标签：$tag"
      if [ "$DRY_RUN" != "true" ]; then
        gh release delete "$tag" --yes || true
        git push origin --delete "$tag" || true
      fi
    fi
  done

  echo -e "\n🔢 开始筛选超出保留数量的旧版本..."
  gh release list --json tagName -q ".[${KEEP_LATEST}:][] | .tagName" | while read -r tag; do
    [ -z "$tag" ] && continue
    echo "🗑️ 待删除版本标签：$tag"
    if [ "$DRY_RUN" != "true" ]; then
      gh release delete "$tag" --yes || true
      git push origin --delete "$tag" || true
    fi
  done

  echo -e "\n✅ 版本与标签清理流程执行完毕"
fi

# ===================== 3. 清理Actions缓存 =====================
if [[ "${CLEAN_TYPE}" == "cache" ]]; then
  echo "============================================="
  echo "💾 清理GitHub Actions构建缓存"
  echo "保留最新缓存条数：$KEEP_LATEST"
  echo "保留缓存时长：$KEEP_DAYS 天"
  echo "============================================="

  echo -e "\n📅 开始筛选过期缓存..."
  gh cache list --json id,createdAt --jq '.[] | [.id, .createdAt] | @tsv' | while read -r id createdAt; do
    [ -z "$id" ] && continue
    if [[ $(date -d "$createdAt" +%s) -lt $(date -d "-${KEEP_DAYS} days" +%s) ]]; then
      echo "🗑️ 待删除缓存ID：$id"
      [ "$DRY_RUN" != "true" ] && gh cache delete "$id" || echo "⚠️ 删除失败跳过"
    fi
  done

  echo -e "\n🔢 开始筛选超出保留数量的旧缓存..."
  gh cache list --json id --jq ".[${KEEP_LATEST}:][] | .id" | while read -r id; do
    [ -n "$id" ] || continue
    echo "🗑️ 待删除缓存ID：$id"
    [ "$DRY_RUN" != "true" ] && gh cache delete "$id" || echo "⚠️ 删除失败跳过"
  done

  echo -e "\n✅ 缓存清理流程执行完毕"
fi
