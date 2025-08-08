---
title: "Cursor Rules 시스템"
tags: [개발도구, Cursor, AI, 생산성]
---

# Cursor Rules 시스템

## 개요

Cursor의 Rules 시스템은 AI 에이전트의 행동을 제어하는 재사용 가능한 지시사항을 제공합니다. 시스템 레벨의 지시사항으로 생각하면 되며, 프로젝트에 대한 지속적인 컨텍스트, 선호도, 워크플로우를 제공합니다.

## Rules 유형

### 1. Project Rules
- **위치**: `.cursor/rules` 디렉토리
- **특징**: 버전 관리되며 코드베이스에 범위가 지정됨
- **용도**: 
  - 도메인별 지식 인코딩
  - 프로젝트별 워크플로우 자동화
  - 스타일이나 아키텍처 결정 표준화

### 2. User Rules
- **위치**: Cursor Settings → Rules
- **특징**: 모든 프로젝트에 적용되는 글로벌 선호도
- **용도**: 통신 스타일이나 코딩 컨벤션 설정

### 3. .cursorrules (Legacy)
- **위치**: 프로젝트 루트의 `.cursorrules` 파일
- **상태**: 지원되지만 deprecated
- **권장**: Project Rules로 마이그레이션

## Rule 유형별 적용 방식

| Rule Type | 설명 |
|-----------|------|
| Always | 항상 모델 컨텍스트에 포함 |
| Auto Attached | glob 패턴과 일치하는 파일이 참조될 때 포함 |
| Agent Requested | AI가 포함 여부를 결정 (description 필수) |
| Manual | @ruleName으로 명시적으로 언급될 때만 포함 |

## Rule 작성 예시

### MDC 형식 사용
```markdown
---
description: RPC Service boilerplate
globs: ["**/*.ts"]
alwaysApply: false
---

- Use our internal RPC pattern when defining services
- Always use snake_case for service names.

@service-template.ts
```

### 파일 참조
`@filename.ts`를 사용하여 Rule의 컨텍스트에 파일을 포함할 수 있습니다.

## 중첩된 Rules

프로젝트 전체에 걸쳐 `.cursor/rules` 디렉토리를 배치하여 규칙을 구성할 수 있습니다:

```
project/
  .cursor/rules/        # 프로젝트 전체 규칙
  backend/
    server/
      .cursor/rules/    # 백엔드 특화 규칙
  frontend/
    .cursor/rules/      # 프론트엔드 특화 규칙
```

## Rules 생성 방법

### 1. 명령어 사용
- `New Cursor Rule` 명령어 사용
- `Cursor Settings > Rules`에서 생성

### 2. 채팅에서 생성
- `/Generate Cursor Rules` 명령어 사용
- 에이전트 행동에 대한 결정사항을 재사용 가능한 규칙으로 변환

## 모범 사례

### 좋은 Rule의 특징
- **집중적**: 특정 목적에 맞춤
- **실행 가능**: 구체적인 지침 제공
- **범위 지정**: 적절한 스코프 설정
- **500줄 이하**: 간결하게 유지
- **재사용 가능**: 여러 규칙으로 분할

### 예시

#### 프론트엔드 컴포넌트 표준
```markdown
---
description: Frontend component standards
globs: ["**/components/**/*.tsx"]
alwaysApply: true
---

When working in components directory:
- Always use Tailwind for styling
- Use Framer Motion for animations
- Follow component naming conventions
```

#### API 검증 표준
```markdown
---
description: API validation standards
globs: ["**/api/**/*.ts"]
alwaysApply: true
---

In API directory:
- Use zod for all validation
- Define return types with zod schemas
- Export types generated from schemas
```

## 활용 사례

### 1. 개발 워크플로우 자동화
```markdown
---
description: App analysis workflow
alwaysApply: false
---

When asked to analyze the app:
1. Run dev server with `npm run dev`
2. Fetch logs from console
3. Suggest performance improvements
```

### 2. 문서 생성 도움
```markdown
---
description: Documentation generation
alwaysApply: false
---

Help draft documentation by:
- Extracting code comments
- Analyzing README.md
- Generating markdown documentation
```

## FAQ

### Q: Rule이 적용되지 않는 이유는?
A: Rule 유형을 확인하세요. `Agent Requested`의 경우 description이 정의되어야 하고, `Auto Attached`의 경우 파일 패턴이 참조된 파일과 일치해야 합니다.

### Q: Rule이 다른 Rule이나 파일을 참조할 수 있나요?
A: 네. `@filename.ts`를 사용하여 Rule의 컨텍스트에 파일을 포함할 수 있습니다.

### Q: 채팅에서 Rule을 생성할 수 있나요?
A: 네. `/Generate Cursor Rules` 명령어를 사용하여 채팅에서 프로젝트 규칙을 생성할 수 있습니다.

### Q: Rule이 Cursor Tab이나 다른 AI 기능에 영향을 주나요?
A: 아니요. Rule은 Agent와 Inline Edit에만 적용됩니다.

## 참고 자료

- [Cursor Rules 공식 문서](https://docs.cursor.com/en/context/rules#generating-rules)
- [Cursor 홈페이지](https://cursor.com)
- [Cursor 커뮤니티](https://discord.gg/cursor) 