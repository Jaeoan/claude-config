#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "┌─────────────────────────────────────────┐"
echo "│         claude-config 프로젝트 셋업        │"
echo "└─────────────────────────────────────────┘"
echo ""

# templates/ 에서 init.sh 있는 템플릿 자동 탐색
templates=()
labels=()

for dir in "$SCRIPT_DIR"/templates/*/; do
  if [[ -f "$dir/init.sh" ]]; then
    name="$(basename "$dir")"
    templates+=("$name")
    if [[ -f "$dir/CLAUDE.md" ]]; then
      label="$(head -1 "$dir/CLAUDE.md" | sed 's/^# //')"
    else
      label="$name"
    fi
    labels+=("$label")
  fi
done

if [[ ${#templates[@]} -eq 0 ]]; then
  echo "사용 가능한 템플릿이 없습니다."
  exit 1
fi

echo "템플릿을 선택하세요:"
echo ""
for i in "${!templates[@]}"; do
  echo "  $((i + 1)). ${labels[$i]}"
done
echo ""

read -rp "번호 입력: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#templates[@]} )); then
  echo "잘못된 입력입니다."
  exit 1
fi

selected="${templates[$((choice - 1))]}"

echo ""
read -rp "프로젝트 이름 (기본값: my-app): " project_name
project_name="${project_name:-my-app}"

echo ""
bash "$SCRIPT_DIR/templates/$selected/init.sh" "$project_name"
