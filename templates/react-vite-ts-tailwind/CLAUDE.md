# React + Vite + TypeScript + Tailwind CSS 프로젝트

## 스택

- React 18+
- Vite (빌드 도구)
- TypeScript (strict 모드)
- Tailwind CSS v4
- React Router DOM v6+
- Vitest + Testing Library (테스트)

## 명령어

| 명령어 | 설명 |
|--------|------|
| `npm run dev` | 개발 서버 실행 |
| `npm run build` | 프로덕션 빌드 |
| `npm run preview` | 빌드 결과 미리보기 |
| `npm run test` | 테스트 실행 (watch) |
| `npm run test:run` | 테스트 단회 실행 |
| `npm run lint` | ESLint 실행 |
| `npm run format` | Prettier 포매팅 |

## 코딩 규칙

### 컴포넌트
- 함수형 컴포넌트만 사용
- 화살표 함수 지양, `function` 선언 사용
- props는 `interface`로 정의

### 파일명
- 컴포넌트: PascalCase (`UserCard.tsx`)
- 유틸/훅: camelCase (`useAuth.ts`, `formatDate.ts`)

### 디렉토리 구조

```
src/
├── components/   # 재사용 컴포넌트
├── pages/        # 라우트별 페이지
├── hooks/        # 커스텀 훅
└── utils/        # 유틸리티 함수
```

### 스타일
- Tailwind 클래스 우선 사용
- 인라인 `style`과 별도 CSS 파일은 정말 필요할 때만

### TypeScript
- `any` 금지 — `unknown` + 타입 가드 사용
- strict 모드 준수

### import 순서
1. 외부 라이브러리 (`react`, `react-router-dom` 등)
2. 내부 절대 경로 (`@/`)
3. 상대 경로 (`./`, `../`)

## 작업 방식
- 새 컴포넌트 생성 시 테스트 파일도 함께 생성
- 외부 라이브러리 추가 전 사용자에게 확인 요청
- `any` 타입 감지 시 즉시 수정

## 주의사항
- `.env*` 파일은 절대 커밋 금지
- `dist/`, `build/` 디렉토리 수정 금지
