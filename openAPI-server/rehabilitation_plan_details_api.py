from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Dict, Any
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, Integer, String, Text, JSON

# ORM模型
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

class RehabilitationPlanDetails(Base):
    __tablename__ = "rehabilitation_plan_details"
    id = Column(Integer, primary_key=True, autoincrement=True)
    patient_id = Column(String(20))
    title = Column(String(100))
    tips_title = Column(String(50))
    tips_content = Column(Text)
    sections = Column(JSON)

# Pydantic模型
class TipsModel(BaseModel):
    title: str
    content: str

class SectionModel(BaseModel):
    title: str
    items: List[str]

class PlanDetailResponseModel(BaseModel):
    title: str
    tips: TipsModel
    sections: List[SectionModel]

router = APIRouter()

@router.get("/rehabilitation_plan_details/patient/{patient_id}", response_model=List[PlanDetailResponseModel])
def get_plan_details_by_patient(patient_id: str, db: Session = Depends(get_db)):
    details = db.query(RehabilitationPlanDetails).filter_by(patient_id=patient_id).all()
    if not details:
        raise HTTPException(status_code=404, detail="未找到康复计划详情")
    result = []
    for d in details:
        # sections字段为json，需转为List[SectionModel]
        sections = d.sections
        if isinstance(sections, str):
            import json
            sections = json.loads(sections)
        result.append({
            "title": d.title,
            "tips": {"title": d.tips_title, "content": d.tips_content},
            "sections": sections
        })
    return result

# 便于其他API导入
__all__ = ["router", "RehabilitationPlanDetails"]
