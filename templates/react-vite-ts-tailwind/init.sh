#!/bin/bash
set -e

PROJECT_NAME="${1:-my-app}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "  React + Vite + TS + Tailwind 셋업"
echo "  프로젝트: $PROJECT_NAME"
echo "======================================"

echo ""
echo "[1/12] 프로젝트 생성 중: $PROJECT_NAME ..."
npm create vite@latest "$PROJECT_NAME" -- --template react-ts

echo ""
echo "[2/12] 기본 의존성 설치 중..."
cd "$PROJECT_NAME"
npm install

echo ""
echo "[3/12] react-router-dom 설치 중..."
npm install react-router-dom

echo ""
echo "[4/12] Tailwind CSS v4 설치 중..."
npm install -D tailwindcss @tailwindcss/vite

echo ""
echo "[5/12] vite.config.ts 구성 중..."
cp "$SCRIPT_DIR/snippets/vite.config.ts" vite.config.ts

echo ""
echo "[6/12] src/index.css Tailwind 임포트로 교체 중..."
cat > src/index.css << 'EOF'
@import "tailwindcss";
EOF

echo ""
echo "[7/12] src/App.tsx 교체 중 (동작 확인용)..."
cp "$SCRIPT_DIR/snippets/App.tsx.example" src/App.tsx

echo ""
echo "[8/12] 개발 도구 설치 중..."
npm install -D @types/node prettier eslint-config-prettier vitest @testing-library/react @testing-library/jest-dom jsdom

echo ""
echo "[9/12] Vitest 셋업 파일 생성 중..."
mkdir -p src/test
cat > src/test/setup.ts << 'EOF'
import '@testing-library/jest-dom'
EOF

echo ""
echo "[10/12] package.json 스크립트 및 path alias 설정 중..."
node -e "
const fs = require('fs');

const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
pkg.scripts.test = 'vitest';
pkg.scripts['test:run'] = 'vitest run';
pkg.scripts.format = 'prettier --write .';
pkg.scripts['format:check'] = 'prettier --check .';
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');

const tsconfigFile = fs.existsSync('tsconfig.app.json') ? 'tsconfig.app.json' : 'tsconfig.json';
const tsconfig = JSON.parse(fs.readFileSync(tsconfigFile, 'utf8'));
if (!tsconfig.compilerOptions) tsconfig.compilerOptions = {};
tsconfig.compilerOptions.baseUrl = '.';
tsconfig.compilerOptions.paths = { '@/*': ['./src/*'] };
fs.writeFileSync(tsconfigFile, JSON.stringify(tsconfig, null, 2) + '\n');

console.log('완료');
"

cat > .prettierrc << 'EOF'
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 100
}
EOF

cat > .prettierignore << 'EOF'
dist
node_modules
EOF

echo ""
echo "[11/12] Claude 설정 적용 중..."
INSTALL_URL="https://raw.githubusercontent.com/Jaeoan/claude-config/main/install.sh"
if curl -fsSL "$INSTALL_URL" -o /tmp/claude_install.sh 2>/dev/null; then
  bash /tmp/claude_install.sh
  rm -f /tmp/claude_install.sh
else
  echo "  ⚠️  Claude 설정 다운로드 실패 — install.sh를 수동으로 실행해주세요"
  echo "  URL: $INSTALL_URL"
fi

echo ""
echo "[12/12] CLAUDE.md · 슬래시커맨드 복사 및 git 초기화..."
cp "$SCRIPT_DIR/CLAUDE.md" CLAUDE.md

if [[ -d "$SCRIPT_DIR/commands" ]]; then
  mkdir -p .claude/commands
  cp "$SCRIPT_DIR/commands/"*.md .claude/commands/
fi
git init
git add .
git commit -m "feat: initial setup (React + Vite + TypeScript + Tailwind CSS v4 + React Router DOM)"

echo ""
echo "======================================"
echo "  ✅ 셋업 완료!"
echo "======================================"
echo ""
echo "다음 단계:"
echo "  cd $PROJECT_NAME"
echo "  npm run dev     ← 개발 서버 실행"
echo "  claude          ← Claude Code 실행"
echo ""
