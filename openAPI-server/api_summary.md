# 康复管理系统 API 接口汇总

## 基础信息
- **基础URL**: `http://127.0.0.1:8000/api/v1`
- **数据库**: MySQL
- **框架**: FastAPI
- **ORM**: SQLAlchemy

---

## 1. 患者管理 (patients_api.py)

### 基础CRUD接口
- **GET** `/patients` - 获取所有患者信息（支持分页）
- **GET** `/patients/{patient_id}` - 根据ID获取单个患者信息
- **POST** `/patients` - 创建新患者
- **PUT** `/patients/{patient_id}` - 更新患者信息
- **DELETE** `/patients/{patient_id}` - 删除患者

### 请求参数
- `skip`: 跳过的记录数（默认0）
- `limit`: 返回的记录数（默认100）

### 响应示例
```json
{
    "id": "10000",
    "name": "张三",
    "gender": "男",
    "age": 65,
    "admission_date": "2025-01-15",
    "department": "神经内科",
    "hospital_number": "HN20250115001",
    "attending_physician": "李医生",
    "head_nurse": "王护士",
    "diagnosis": "脑卒中",
    "rehabilitation_doctor": "陈康复师",
    "rehab_count": 5,
    "completion_rate": 80,
    "physical_recovery": 75,
    "NIHSS_score": 8
}
```

---

## 2. 血压监测 (blood_pressure_monitor_api.py)

### 基础CRUD接口
- **GET** `/blood_pressure_monitor` - 获取所有血压监测数据
- **GET** `/blood_pressure_monitor/{patient_id}` - 根据患者ID获取血压监测数据
- **POST** `/blood_pressure_monitor` - 创建血压监测数据
- **PUT** `/blood_pressure_monitor/{patient_id}` - 更新血压监测数据
- **DELETE** `/blood_pressure_monitor/{patient_id}` - 删除血压监测数据

### 响应示例
```json
{
    "patient_id": "10000",
    "record_date": "2025-07-13",
    "heart_rate": [85, 88, 90, 92, 95, 98, 100, 105, 108, 110, 108, 105, 102, 100, 98, 96, 95, 93, 90, 88, 86, 84, 82, 80],
    "systolic_pressure": [140, 142, 145, 148, 150, 155, 158, 160, 162, 165, 163, 160, 158, 155, 152, 150, 148, 145, 142, 140, 138, 136, 134, 132],
    "diastolic_pressure": [85, 86, 88, 90, 92, 94, 96, 98, 100, 102, 100, 98, 96, 94, 92, 90, 88, 86, 84, 82, 80, 78, 76, 74]
}
```

---

## 3. 生命体征 (vital_signs_api.py)

### 基础CRUD接口
- **GET** `/vital_signs` - 获取所有生命体征数据（支持分页）
- **GET** `/vital_signs/{vital_signs_id}` - 根据ID获取单个生命体征数据
- **POST** `/vital_signs` - 创建新的生命体征数据
- **PUT** `/vital_signs/{vital_signs_id}` - 更新生命体征数据
- **DELETE** `/vital_signs/{vital_signs_id}` - 删除生命体征数据

### 响应示例
```json
{
    "id": 1,
    "patient_id": "10000",
    "record_time": "2025-07-13T00:58:30",
    "HR": 88,
    "SBP": 145,
    "ICP": 15,
    "MAP": 92,
    "temperature": 36.8,
    "RR": 18,
    "SpO2": 96,
    "PEEP": 8,
    "FiO2": 0.35
}
```

---

## 4. 医疗排班 (medical_schedules_api.py)

### 医生管理接口
- **GET** `/doctors/assigned` - 获取当天有排班的医生
- **GET** `/doctors/all` - 获取所有医生及其排班信息
- **POST** `/doctors/assign` - 变更当天排班

### 排班请求格式
```json
{
    "schedule": [1, 2, 3, null, 1, 2, 3, null, 1, 2, 3, null, 1, 2, 3, null, 1, 2, 3, null, 1, 2, 3, null]
}
```

### 响应示例
```json
{
    "id": 1,
    "name": "张医生",
    "department": "理疗科",
    "today_schedule": [0, 4, 8, 12, 16, 20]
}
```

---

## 5. 康复路径 (pathway.py)

### 基础CRUD接口
- **GET** `/rehabilitation_pathways` - 获取所有康复路径数据（支持分页）
- **GET** `/rehabilitation_pathways/{pathway_id}` - 根据ID获取单个康复路径数据
- **POST** `/rehabilitation_pathways` - 创建新的康复路径数据
- **PUT** `/rehabilitation_pathways/{pathway_id}` - 更新康复路径数据
- **DELETE** `/rehabilitation_pathways/{pathway_id}` - 删除康复路径数据

### 嵌套结构接口
- **GET** `/rehabilitation_pathways/patient/{patient_id}` - 根据患者ID获取康复路径（嵌套结构）

### 嵌套结构响应示例
```json
{
    "part1": {
        "康复评估": {
            "物理评估": ["S5Q", "MRC", "BBS"],
            "作业评估": ["RASS"],
            "吞咽评估": ["MMASA", "FOIS"]
        },
        "康复训练": {
            "物理治疗": ["床上被动运动", "体位管理", "平衡训练"]
        }
    },
    "part2": {
        "康复评估": {
            "物理评估": ["关节活动度", "肌力测试"],
            "作业评估": ["日常生活能力评估"],
            "吞咽评估": ["饮水测试", "食物稠度测试"]
        },
        "康复训练": {
            "物理治疗": ["坐位平衡训练", "床边站立训练"]
        }
    },
    "part3": {
        "康复评估": {
            "物理评估": ["步态分析", "耐力测试"],
            "作业评估": ["手功能评估", "认知功能测试"],
            "吞咽评估": ["咽部敏感度测试"]
        },
        "康复训练": {
            "物理治疗": ["步行训练", "上下楼梯训练"]
        }
    }
}
```

---

## 6. 康复计划详情 (rehabilitation_plan_details_api.py)

### 基础CRUD接口
- **GET** `/rehabilitation_plan_details` - 获取所有康复计划详情数据（支持分页）
- **GET** `/rehabilitation_plan_details/{detail_id}` - 根据ID获取单个康复计划详情数据
- **POST** `/rehabilitation_plan_details` - 创建新的康复计划详情数据
- **PUT** `/rehabilitation_plan_details/{detail_id}` - 更新康复计划详情数据
- **DELETE** `/rehabilitation_plan_details/{detail_id}` - 删除康复计划详情数据

### 嵌套结构接口
- **GET** `/rehabilitation_plan_details/patient/{patient_id}` - 根据患者ID获取康复计划详情（嵌套结构）

### 初始化接口
- **POST** `/rehabilitation_plan_details/init` - 初始化测试数据

### 嵌套结构响应示例
```json
{
    "物理康复：": [
        "被动关节活动训练：肩、肘、髋、膝各关节，每个方向10次，每日2次",
        "体位变换训练：每2小时翻身一次，预防压疮",
        "床上坐位平衡训练：5分钟/次，3次/日"
    ],
    "作业康复：": [
        "多感官刺激：使用不同材质物品进行触觉刺激，10分钟/次，2次/日",
        "简单抓握训练：使用软球进行抓握练习，5分钟/次，3次/日"
    ],
    "吞咽康复：": [
        "口腔感觉刺激：冰棉签刺激口腔肌肉，5分钟/次，3次/日",
        "吞咽动作训练：空吞咽练习，10次/组，3组/日"
    ]
}
```

---

## 7. 康复计划 (rehabilitation_plans_api.py)

### 基础CRUD接口
- **GET** `/rehabilitation_plans` - 获取所有康复计划数据（支持分页）
- **GET** `/rehabilitation_plans/{plan_id}` - 根据ID获取单个康复计划数据
- **POST** `/rehabilitation_plans` - 创建新的康复计划数据
- **PUT** `/rehabilitation_plans/{plan_id}` - 更新康复计划数据
- **DELETE** `/rehabilitation_plans/{plan_id}` - 删除康复计划数据

### 患者相关接口
- **GET** `/rehabilitation_plans/patient/{patient_id}` - 根据患者ID获取该患者的所有康复计划

### 康复方案接口
- **GET** `/rehabilitation_schemes` - 获取所有康复方案模板（期望格式）

### 康复方案响应示例
```json
[
    {
        "title": "康复方案",
        "tips": {
            "title": "Tips1：",
            "content": "请仔细检查病人是否有严重的感染性疾病、近期心肌梗死、未控制的癫痫发作、大面积脑卒中急性期等康复训练禁忌症"
        },
        "sections": [
            {
                "title": "物理康复：",
                "items": [
                    "平衡训练（单腿站立、闭目站立，每次保持 10 - 15 秒，重复 8 - 10 次，一日 3 次）",
                    "步行训练（借助平行杠、助行器逐步过渡到独立行走，每次 30 分钟，一日 2 - 3 次）",
                    "关节活动度训练（上肢、下肢各关节的屈伸、旋转，每个动作保持 15 - 30 秒，重复 10 - 15 次，一日 3 次）",
                    "肌力训练（利用弹力带、哑铃进行抗阻训练，根据肌力等级选择合适重量和重复次数，一般 3 - 4 组，每组 8 - 12 次，一日 2 次）"
                ]
            },
            {
                "title": "作业康复：",
                "items": [
                    "手功能训练（捏橡皮泥、穿珠子、拧瓶盖等精细动作，每次 20 - 30 分钟，一日 2 - 3 次）",
                    "认知训练（记忆游戏、数字排序、找不同等，根据认知水平调整难度，每次 20 - 30 分钟，一日 2 次）",
                    "日常生活活动训练（穿衣、进食、洗漱等模拟训练，结合实际情况进行个性化的指导和辅助，每次 30 - 45 分钟，一日 2 - 3 次）"
                ]
            },
            {
                "title": "吞咽康复：",
                "items": [
                    "口腔按摩（对唇部、颊部、舌部等部位进行轻柔按摩，每次 5 - 10 分钟，一日 3 次）",
                    "冰刺激（用冰棉签刺激软腭、咽壁等部位，每次 10 - 15 分钟，一日 2 - 3 次）",
                    "空吞咽训练（在进食前进行多次空吞咽，以提高吞咽反射的敏感度，每次 10 - 15 次，一日 3 - 5 次）"
                ]
            }
        ]
    }
]
```

---

## 8. 日常评估 (daily_assessments_api.py)

### 基础CRUD接口
- **GET** `/daily_assessments` - 获取所有日常评估数据（支持分页）
- **GET** `/daily_assessments/{assessment_id}` - 根据ID获取单个日常评估数据
- **POST** `/daily_assessments` - 创建新的日常评估数据
- **PUT** `/daily_assessments/{assessment_id}` - 更新日常评估数据
- **DELETE** `/daily_assessments/{assessment_id}` - 删除日常评估数据

---

## 9. 周评估 (weekly_assement_api.py)

### 基础CRUD接口
- **GET** `/weekly_assessments` - 获取所有周评估数据（支持分页）
- **GET** `/weekly_assessments/{assessment_id}` - 根据ID获取单个周评估数据
- **POST** `/weekly_assessments` - 创建新的周评估数据
- **PUT** `/weekly_assessments/{assessment_id}` - 更新周评估数据
- **DELETE** `/weekly_assessments/{assessment_id}` - 删除周评估数据

---

## 通用响应格式

### 成功响应
```json
{
    "data": {...},
    "message": "操作成功"
}
```

### 错误响应
```json
{
    "detail": "错误描述信息"
}
```

### 分页响应
```json
{
    "items": [...],
    "total": 100,
    "page": 1,
    "size": 10,
    "pages": 10
}
```

---

## 状态码说明

- **200**: 请求成功
- **201**: 创建成功
- **400**: 请求参数错误
- **404**: 资源未找到
- **422**: 数据验证错误
- **500**: 服务器内部错误

---

## 使用示例

### 获取康复方案模板
```bash
curl -X GET "http://127.0.0.1:8000/api/v1/rehabilitation_schemes"
```

### 获取患者10000的康复路径
```bash
curl -X GET "http://127.0.0.1:8000/api/v1/rehabilitation_pathways/patient/10000"
```

### 创建新患者
```bash
curl -X POST "http://127.0.0.1:8000/api/v1/patients" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "李四",
    "gender": "女",
    "age": 58,
    "admission_date": "2025-01-20",
    "department": "神经内科",
    "hospital_number": "HN20250120001",
    "attending_physician": "王医生",
    "head_nurse": "李护士",
    "diagnosis": "脑梗塞",
    "rehabilitation_doctor": "张康复师",
    "rehab_count": 3,
    "completion_rate": 70,
    "physical_recovery": 65,
    "NIHSS_score": 6
  }'
```

### 获取患者10000的康复计划详情
```bash
curl -X GET "http://127.0.0.1:8000/api/v1/rehabilitation_plan_details/patient/10000"
```

### 初始化康复计划详情测试数据
```bash
curl -X POST "http://127.0.0.1:8000/api/v1/rehabilitation_plan_details/init"
```

---

## 注意事项

1. 所有接口都支持CORS跨域请求
2. 数据库约束已设置为最低，便于测试
3. 所有字段都是可选的，支持部分更新
4. 分页接口默认返回100条记录
5. 嵌套结构接口会自动转换数据格式
6. 外键关联保持完整性
7. 康复方案模板会自动初始化默认数据 