# 使用官方Python基础镜像
FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 先复制依赖文件，利用Docker缓存层加速构建
COPY openAPI-server/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 安装 MySQL 客户端和 nginx
RUN apt-get update && \
    apt-get install -y default-mysql-client nginx dos2unix && \
    rm -rf /var/lib/apt/lists/*

# 复制项目所有文件到容器
COPY . .

# 添加gunicorn安装（WSGI服务器）
RUN pip install --no-cache-dir gunicorn

# 创建前端目录符号链接（适配nginx配置）
RUN mkdir -p /var/www/app && ln -s /app/dist /var/www/app/dist

# 移动nginx配置文件
RUN mv /app/nginx.conf /etc/nginx/conf.d/default.conf

# 创建启动脚本（同时运行后端和nginx）
RUN echo $'#!/usr/bin/env bash\n' \
    '# 等待数据库服务可用\n' \
    'retries=10\n' \
    'while [ $retries -gt 0 ]; do\n' \
    '    if mysqladmin ping -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" --password="$DB_PASSWORD" --silent; then\n' \
    '        break\n' \
    '    fi\n' \
    '    echo "Waiting for database... ($retries retries left)"\n' \
    '    sleep 5\n' \
    '    retries=$((retries-1))\n' \
    'done\n' \
    'if [ $retries -eq 0 ]; then\n' \
    '    echo "ERROR: Database not available after 10 attempts"\n' \
    '    exit 1\n' \
    'fi\n\n' \
    '# 执行数据库初始化\n' \
    'cd /app/database\n' \
    'chmod +x build.sh\n' \
    './build.sh\n' \
    'cd /app\n\n' \
    '# 启动应用服务\n' \
    'gunicorn --bind 0.0.0.0:5000 app:app &\n' \
    '# 启动nginx\n' \
    'nginx -g "daemon off;"\n' > /app/start.sh && \
    chmod +x /app/start.sh

# 转换行尾格式
RUN dos2unix /app/start.sh

# 必需的环境变量 (用于数据库连接检查):
#   DB_HOST: 数据库服务器地址
#   DB_PORT: 数据库服务器端口
#   DB_USER: 数据库用户名
#   DB_PASSWORD: 数据库密码

# 暴露nginx端口
EXPOSE 80

# 使用启动脚本
CMD ["/app/start.sh"]