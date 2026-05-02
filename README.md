# claude-config

Claude Code 프로젝트 설정 및 템플릿 모음.

## 빠른 시작

### 최초 1회 — 클론

```bash
git clone https://github.com/Jaeoan/claude-config ~/claude-config
```

### 새 프로젝트 만들 때마다

```bash
bash ~/claude-config/setup.sh
```

실행하면 메뉴가 뜨고, 템플릿을 고르면 프로젝트명을 입력 받아 자동으로 셋업합니다.

```
┌─────────────────────────────────────────┐
│         claude-config 프로젝트 셋업        │
└─────────────────────────────────────────┘

템플릿을 선택하세요:

  1. React + Vite + TypeScript + Tailwind CSS 프로젝트

번호 입력: 1

프로젝트 이름 (기본값: my-app): my-project
```

특정 템플릿을 바로 실행할 수도 있습니다:

```bash
bash ~/claude-config/templates/react-vite-ts-tailwind/init.sh <프로젝트명>
```

## 템플릿 목록

### 1. React + Vite + TypeScript + Tailwind CSS

| 항목 | 내용 |
|------|------|
| 프레임워크 | React 18 + Vite |
| 언어 | TypeScript (strict) |
| 스타일 | Tailwind CSS v4 |
| 라우팅 | React Router DOM v6 |
| 테스트 | Vitest + Testing Library |
| 기타 | Prettier, Path alias (`@/`) |

**생성 결과**

```
<프로젝트명>/
├── src/
│   ├── test/setup.ts
│   ├── App.tsx        ← Tailwind 동작 확인용 (교체해서 사용)
│   └── index.css
├── .claude/           ← Claude Code 설정
├── .prettierrc
├── CLAUDE.md
├── tsconfig.app.json  ← @/* path alias 포함
└── vite.config.ts     ← Tailwind + Vitest 설정 포함
```

## 새 템플릿 추가

`templates/<템플릿명>/init.sh`를 만들면 `setup.sh` 메뉴에 자동으로 나타납니다.
