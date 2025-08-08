#!/bin/bash

# 우분투 서버 배포 스크립트

# 설정
SERVER_IP="your-server-ip"
SERVER_USER="your-username"
SERVER_PATH="/var/www/quartz"

echo "🚀 Quartz 배포 시작..."

# 1. 빌드
echo "📦 Quartz 빌드 중..."
npx quartz build

# 2. 파일 전송
echo "📤 파일 전송 중..."
rsync -avz --delete public/ $SERVER_USER@$SERVER_IP:$SERVER_PATH/public/

# 3. 서버 설정 파일 전송 (Nginx 사용 시)
echo "⚙️ 서버 설정 전송 중..."
scp nginx-quartz.conf $SERVER_USER@$SERVER_IP:/tmp/

# 4. 서버에서 실행할 명령어들
echo "🔧 서버 설정 적용 중..."
ssh $SERVER_USER@$SERVER_IP << 'EOF'
    # Nginx 설정 적용
    sudo cp /tmp/nginx-quartz.conf /etc/nginx/sites-available/quartz
    sudo ln -sf /etc/nginx/sites-available/quartz /etc/nginx/sites-enabled/
    sudo nginx -t && sudo systemctl reload nginx
    
    # 권한 설정
    sudo chown -R www-data:www-data /var/www/quartz
    sudo chmod -R 755 /var/www/quartz
    
    echo "✅ 배포 완료!"
EOF

echo "🎉 배포가 완료되었습니다!"
echo "🌐 사이트: http://$SERVER_IP" 