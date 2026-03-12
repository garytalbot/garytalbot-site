#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_REPO="${TARGET_REPO:-garytalbot/garytalbot.github.io}"
TARGET_BRANCH="${TARGET_BRANCH:-main}"
TARGET_DIR="${TARGET_DIR:-}"
SYNC_TOKEN="${SYNC_TOKEN:-${GH_TOKEN:-${GITHUB_TOKEN:-}}}"
COMMIT_AUTHOR_NAME="${COMMIT_AUTHOR_NAME:-github-actions[bot]}"
COMMIT_AUTHOR_EMAIL="${COMMIT_AUTHOR_EMAIL:-41898282+github-actions[bot]@users.noreply.github.com}"
DRY_RUN="${DRY_RUN:-0}"
PUSH_CHANGES="${PUSH_CHANGES:-1}"

if [[ -z "${TARGET_DIR}" ]]; then
  if [[ -z "${SYNC_TOKEN}" ]]; then
    echo "SYNC_TOKEN, GH_TOKEN, or GITHUB_TOKEN is required when TARGET_DIR is not provided." >&2
    exit 1
  fi

  TARGET_DIR="$(mktemp -d)"
  cleanup() {
    rm -rf "${TARGET_DIR}"
  }
  trap cleanup EXIT

  git clone --depth 1 --branch "${TARGET_BRANCH}" \
    "https://x-access-token:${SYNC_TOKEN}@github.com/${TARGET_REPO}.git" \
    "${TARGET_DIR}"
fi

if [[ ! -d "${TARGET_DIR}/.git" ]]; then
  echo "TARGET_DIR must point to a git checkout of ${TARGET_REPO}." >&2
  exit 1
fi

rsync -a --delete \
  --exclude '.git/' \
  --exclude '.github/' \
  --exclude 'README.md' \
  --exclude 'scripts/' \
  "${SOURCE_DIR}/" "${TARGET_DIR}/"

SOURCE_HEAD="$(git -C "${SOURCE_DIR}" rev-parse --short HEAD)"
cat > "${TARGET_DIR}/README.md" <<EOF2
# garytalbot.github.io

Root GitHub Pages mirror of Gary Talbot's personal site.

This repository is synced automatically from garytalbot-site:
https://github.com/garytalbot/garytalbot-site

The automation lives in garytalbot-site/scripts/sync-root-pages.sh and garytalbot-site/.github/workflows/sync-root-pages.yml.

- Public front door: <https://garytalbot.github.io/>
- Source repo: <https://github.com/garytalbot/garytalbot-site>
- Latest synced source commit at generation time: ${SOURCE_HEAD}

If you need to change site content, edit garytalbot-site and let the sync workflow mirror it here.
EOF2

if [[ "${DRY_RUN}" == "1" ]]; then
  git -C "${TARGET_DIR}" status --short
  exit 0
fi

if git -C "${TARGET_DIR}" diff --quiet && git -C "${TARGET_DIR}" diff --cached --quiet; then
  echo "No changes to sync."
  exit 0
fi

git -C "${TARGET_DIR}" add -A

if git -C "${TARGET_DIR}" diff --cached --quiet; then
  echo "No staged changes to sync."
  exit 0
fi

git -C "${TARGET_DIR}" config user.name "${COMMIT_AUTHOR_NAME}"
git -C "${TARGET_DIR}" config user.email "${COMMIT_AUTHOR_EMAIL}"

git -C "${TARGET_DIR}" commit -m "chore: sync site from garytalbot-site (${SOURCE_HEAD})"

if [[ "${PUSH_CHANGES}" == "1" ]]; then
  git -C "${TARGET_DIR}" push origin "${TARGET_BRANCH}"
else
  echo "Push skipped because PUSH_CHANGES=${PUSH_CHANGES}."
fi
