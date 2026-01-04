# Docker 部署指南

## 🐳 Docker 部署

本項目支援 Docker 容器化部署，提供快速、一致的部署體驗。

## 📋 前置要求

- **Docker**: 版本 20.10+
- **Docker Compose**: 版本 1.29+（可選，用於本地開發）

### 安裝 Docker

**Windows 10/11**:
```powershell
# 使用 Chocolatey 安裝
choco install docker-desktop

# 或訪問官方網址
# https://www.docker.com/products/docker-desktop
```

**macOS**:
```bash
# 使用 Homebrew 安裝
brew install --cask docker

# 或訪問官方網址
# https://www.docker.com/products/docker-desktop
```

**Linux**:
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose

# 啟動 Docker 服務
sudo systemctl start docker
sudo systemctl enable docker
```

## 🚀 快速開始

### 方式 1: 使用 Docker Compose（推薦本地開發）

**1. 啟動服務**
```bash
docker-compose up -d
```

**2. 訪問應用**
- 打開瀏覽器訪問：`http://localhost:8080`

**3. 查看日誌**
```bash
docker-compose logs -f
```

**4. 停止服務**
```bash
docker-compose down
```

### 方式 2: 使用 Docker 命令

**1. 構建鏡像**
```bash
docker build -t mynotes:latest .
```

**2. 運行容器**
```bash
docker run -d \
  --name mynotes \
  -p 8080:80 \
  -v $(pwd):/usr/share/nginx/html \
  mynotes:latest
```

**3. 訪問應用**
- 打開瀏覽器訪問：`http://localhost:8080`

**4. 停止容器**
```bash
docker stop mynotes
docker rm mynotes
```

## 📦 文件結構說明

### Dockerfile
- **基礎鏡像**: `nginx:alpine` (輕量級，~40MB)
- **功能**: 提供靜態網頁服務
- **暴露端口**: 80

### docker-compose.yml
- **服務名**: web
- **端口映射**: 8080:80
- **掛載點**: 本地文件同步到容器
- **重啟策略**: 自動重啟（除非手動停止）

### nginx.conf
- **Gzip 壓縮**: 自動壓縮靜態資源
- **緩存策略**: 
  - 靜態資源（CSS/JS）：1 年緩存
  - JSON 文件：不緩存（確保最新數據）
  - HTML 文件：不緩存
- **安全頭**: 添加 X-Frame-Options 等安全相關頭
- **健康檢查**: `/health` 端點

### .dockerignore
- 排除不必要的文件，減小鏡像大小
- 提高構建速度

## 🔧 常見命令

### 鏡像管理
```bash
# 列出本地鏡像
docker images

# 刪除鏡像
docker rmi mynotes:latest

# 推送到倉庫（需先登錄）
docker push yourusername/mynotes:latest
```

### 容器管理
```bash
# 列出運行中的容器
docker ps

# 列出所有容器
docker ps -a

# 進入容器終端
docker exec -it mynotes /bin/sh

# 查看容器日誌
docker logs -f mynotes

# 檢查容器健康狀態
docker inspect mynotes
```

### Docker Compose 命令
```bash
# 後臺啟動
docker-compose up -d

# 前臺啟動（顯示日誌）
docker-compose up

# 停止服務
docker-compose stop

# 停止並移除容器
docker-compose down

# 重建鏡像
docker-compose build

# 查看日誌
docker-compose logs -f

# 查看服務狀態
docker-compose ps
```

## 🌐 生產部署

### 部署到遠端服務器

**1. 推送鏡像到倉庫**
```bash
# 登錄 Docker Hub
docker login

# 標籤鏡像
docker tag mynotes:latest yourusername/mynotes:latest

# 推送
docker push yourusername/mynotes:latest
```

**2. 在服務器上拉取並運行**
```bash
ssh user@your-server

# 拉取鏡像
docker pull yourusername/mynotes:latest

# 運行容器
docker run -d \
  --name mynotes \
  -p 80:80 \
  yourusername/mynotes:latest
```

### 使用反向代理（Nginx/Traefik）

**Nginx 反向代理配置**:
```nginx
upstream mynotes {
    server localhost:8080;
}

server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://mynotes;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 📊 性能最佳實踐

### 1. 多階段構建（已實現）
```dockerfile
FROM nginx:alpine
# 減小最終鏡像大小
```

### 2. Gzip 壓縮（已配置）
- 自動壓縮文本文件
- 減少網路傳輸量

### 3. 緩存策略（已配置）
- 靜態資源使用長期緩存
- JSON 文件動態更新無緩存

### 4. 健康檢查
```bash
curl http://localhost:8080/health
```

## 🔐 安全建議

1. **使用環境變數**
   ```bash
   docker run -e ENVIRONMENT=production ...
   ```

2. **限制容器資源**
   ```bash
   docker run -m 256m --cpus 0.5 ...
   ```

3. **使用只讀文件系統**
   ```bash
   docker run --read-only ...
   ```

4. **定期更新基礎鏡像**
   ```bash
   docker pull nginx:alpine
   docker build -t mynotes:latest .
   ```

5. **掃描鏡像漏洞**
   ```bash
   docker scan mynotes:latest
   ```

## 🐛 故障排除

### 端口已被佔用
```bash
# 查看占用 8080 端口的進程
lsof -i :8080

# 或使用其他端口
docker run -p 3000:80 mynotes:latest
```

### 容器啟動失敗
```bash
# 查看日誌
docker logs mynotes

# 進入容器調試
docker exec -it mynotes /bin/sh
```

### JSON 文件不更新
```bash
# 檢查 nginx.conf 中 JSON 緩存設置
# 確保沒有過期時間限制

# 清除瀏覽器緩存或硬刷新
Ctrl + Shift + R (Chrome/Firefox)
```

## 📈 擴展部署

### 使用 Kubernetes

**簡單的 Kubernetes 部署**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mynotes
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mynotes
  template:
    metadata:
      labels:
        app: mynotes
    spec:
      containers:
      - name: mynotes
        image: yourusername/mynotes:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: mynotes-service
spec:
  selector:
    app: mynotes
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
```

## 📚 相關資源

- [Docker 官方文檔](https://docs.docker.com/)
- [Nginx 官方鏡像](https://hub.docker.com/_/nginx)
- [Docker Compose 文檔](https://docs.docker.com/compose/)
- [Docker 安全最佳實踐](https://docs.docker.com/engine/security/)

---

**最後更新**: 2026 年 1 月 4 日
