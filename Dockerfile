# 多阶段构建 - 最小化镜像大小
FROM nginx:alpine

# 设置工作目录
WORKDIR /app

# 复制所有文件到 nginx 提供的目录
COPY . /usr/share/nginx/html/

# 复制自定义 nginx 配置（可选）
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动 nginx
CMD ["nginx", "-g", "daemon off;"]
