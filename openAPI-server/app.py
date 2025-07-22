from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from patients_api import router as patients_router
from daily_assessments_api import router as daily_assessments_router
from medical_schedules_api import router as medical_schedules_router
from blood_pressure_monitor_api import router as blood_pressure_monitor_router
from weekly_assement_api import router as weekly_assessment_router
from vital_signs_api import router as vital_signs_router
from pathway import router as pathway_router
from rehabilitation_plan_details_api import router as rehabilitation_plan_details_router
from rehabilitation_plans_api import router as rehabilitation_plans_router
from physiological_risks_api import router as physiological_risks_router
from .database import Base, engine

# 创建表（如已存在不会重复创建）
Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(patients_router, prefix="/api/v1")
app.include_router(daily_assessments_router, prefix="/api/v1")
app.include_router(medical_schedules_router, prefix="/api/v1")
app.include_router(blood_pressure_monitor_router, prefix="/api/v1")
app.include_router(weekly_assessment_router, prefix="/api/v1")
app.include_router(vital_signs_router, prefix="/api/v1")
app.include_router(pathway_router, prefix="/api/v1")
app.include_router(rehabilitation_plan_details_router, prefix="/api/v1")
app.include_router(rehabilitation_plans_router, prefix="/api/v1")
app.include_router(physiological_risks_router, prefix="/api/v1")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)