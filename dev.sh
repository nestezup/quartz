#!/bin/bash

echo "🔄 Quartz 개발 서버 시작..."

# 초기 빌드
echo "📦 초기 빌드 중..."
npx quartz build

# 파일 변경 감지 및 자동 빌드
echo "👀 파일 변경 감지 중..."
fswatch -o content quartz.layout.ts quartz.config.ts | while read f; do
    echo "🔄 변경사항 감지됨. 다시 빌드 중..."
    npx quartz build
    echo "✅ 빌드 완료! http://localhost:4000 에서 확인하세요."
done 