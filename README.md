# vssr 康复管理系统

## 项目简介

本项目为一套康复管理系统，集成了后端 API 服务、数据库初始化脚本、前端静态资源、Docker 一键部署与 nginx 反向代理配置，适用于医疗康复场景下的患者信息、评估、康复计划等数据管理。

---

## 目录结构

```
project/
├── database/                # 数据库初始化脚本及SQL
│   ├── build.sh             # 数据库一键初始化脚本
│   └── vssr.sql             # MySQL建表及示例数据
├── dist/                    # 前端静态资源（可直接由nginx托管）
├── openAPI-server/          # 后端API服务（FastAPI）
│   ├── app.py               # FastAPI主入口
│   ├── requirements.txt     # Python依赖
│   ├── *.py                 # 各功能API模块
│   └── Dockerfile           # 后端服务Docker构建文件
├── Dockerfile               # 项目整体Docker部署（含nginx、gunicorn、数据库初始化）
├── nginx.conf               # nginx反向代理与静态资源配置
└── README.md                # 项目说明文档
```

---

## 主要功能

- 患者信息管理
- 血压监测、生命体征、日常/周评估
- 医疗排班、康复路径、康复计划及详情
- 完整RESTful API，支持分页、嵌套结构、模板初始化等
- 前端静态资源一键部署
- 支持Docker一键部署，内置nginx反向代理
- 数据库一键初始化脚本

---

## 安装与运行

### 1. 环境准备
- Python 3.9+
- MySQL 8.0+
- 推荐使用 Docker 部署（无需本地安装Python/MySQL）

### 2. 数据库初始化（如不使用Docker）

```bash
cd database
# 可自定义环境变量：DB_HOST、DB_PORT、DB_USER、DB_PASSWORD、DB_NAME
bash build.sh
```

### 3. 后端API服务本地运行

```bash
cd openAPI-server
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000
```

### 4. Docker 一键部署（推荐）

```bash
docker build -t vssr-app .
docker run -d \
  -e DB_HOST=你的数据库地址 \
  -e DB_PORT=3306 \
  -e DB_USER=用户名 \
  -e DB_PASSWORD=密码 \
  -e DB_NAME=vssr \
  -p 80:80 \
  vssr-app
```
- 默认前端静态资源通过 nginx 提供，API 通过 `/api/v1` 反向代理到后端
- 端口80为nginx对外端口

---

## nginx 配置说明

- `/` 路径：服务前端静态资源（dist目录）
- `/api/v1` 路径：反向代理到后端API（默认 127.0.0.1:5000）

详见 `nginx.conf` 文件：

```nginx
server {
    listen 80;
    server_name _;
    location / {
        root /var/www/app/dist;
        try_files $uri $uri/ /index.html;
    }
    location /api/v1 {
        proxy_pass http://127.0.0.1:5000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## 主要API接口（简要）

- `/api/v1/patients` 患者管理
- `/api/v1/blood_pressure_monitor` 血压监测
- `/api/v1/vital_signs` 生命体征
- `/api/v1/medical_schedules` 医疗排班
- `/api/v1/pathway` 康复路径
- `/api/v1/rehabilitation_plan_details` 康复计划详情
- `/api/v1/rehabilitation_plans` 康复计划
- `/api/v1/daily_assessments` 日常评估
- `/api/v1/weekly_assessments` 周评估

详细接口文档见 `openAPI-server/api_summary.md`

---

## 数据库说明

- 默认数据库名：`vssr`
- 主要表：patients、blood_pressure_monitor、vital_signs、daily_assessments、doctors、medical_schedules、rehabilitation_plans、rehabilitation_plan_details、pathway、physiological_risks、weekly_assessments 等
- 初始化脚本支持自定义数据库连接参数

---

## 许可证

本项目仅供学习与内部交流使用，禁止商业用途。

---

## 联系方式

如有问题请联系项目维护者。 