# 使用 Python 3.9 官方镜像作为基础
FROM python:3.9

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器
COPY . .

# 如果没有 requirements.txt，请先在本地生成
RUN pip install --no-cache-dir -r requirements.txt

# 暴露端口（与 docker-compose 映射一致）
EXPOSE 8000  

# 使用环境变量PORT，默认值8000
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"]