---
title: "이미지 사용법"
---

# 이미지 사용법

## 폴더 구조
```
content/
├── images/          # 공통 이미지
│   ├── logo.png
│   ├── diagrams/
│   └── screenshots/
├── project/
│   ├── project-specific.png
│   └── tech-stack.md
```

## 마크다운에서 사용
```markdown
# 상대 경로
![설명](./image.png)

# 절대 경로 (content 폴더 기준)
![설명](/images/logo.png)

# 크기 조정
![설명](/images/diagram.png){width=500 height=300}
```

## 권장사항
- **파일명**: 영문, 소문자, 하이픈 사용
- **크기**: 웹 최적화 (1MB 이하 권장)
- **형식**: PNG(투명도), JPG(사진), SVG(벡터) 