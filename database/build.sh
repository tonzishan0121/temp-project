#!/bin/bash
set -e  # 遇到错误立即退出

echo "Starting database initialization..."

# 从环境变量获取数据库连接参数，设置默认值
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-root}"
DB_NAME="${DB_NAME:-vssr}"  # 添加DB_NAME环境变量支持

# SQL 文件路径
SQL_FILE="vssr.sql"

# 检查 SQL 文件是否存在
if [ ! -f "$SQL_FILE" ]; then
    echo "Error: SQL file $SQL_FILE not found!"
    exit 1
fi

# 测试数据库连接
echo "Testing database connection to ${DB_HOST}:${DB_PORT}..."
if ! mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; then
    echo "Error: Cannot connect to MySQL server"
    exit 1
fi

# 创建数据库（如果不存在）
echo "Creating database ${DB_NAME} if not exists..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"

# 导入 SQL 文件
echo "Importing SQL schema and data..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$SQL_FILE"

echo "Database initialization completed successfully."