from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Dict, Any
from pydantic import BaseModel
from database import SessionLocal
from rehabilitation_plan_details_api import RehabilitationPlanDetails  # 正确导入

class TipsModel(BaseModel):
    title: str
    content: str

class SectionModel(BaseModel):
    title: str
    items: List[str]

class PlanResponseModel(BaseModel):
    title: str
    tips: TipsModel
    sections: List[SectionModel]

class PlanCreateModel(BaseModel):
    patient_id: str
    title: str
    tips_title: str
    tips_content: str
    sections: List[Dict[str, Any]]

class PlanUpdateModel(BaseModel):
    title: str = None
    tips_title: str = None
    tips_content: str = None
    sections: List[Dict[str, Any]] = None

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/rehabilitation_plan", response_model=PlanResponseModel)
def create_plan(plan: PlanCreateModel, db: Session = Depends(get_db)):
    db_plan = RehabilitationPlanDetails(
        patient_id=plan.patient_id,
        title=plan.title,
        tips_title=plan.tips_title,
        tips_content=plan.tips_content,
        sections=plan.sections
    )
    db.add(db_plan)
    db.commit()
    db.refresh(db_plan)
    return {
        "title": db_plan.title,
        "tips": {"title": db_plan.tips_title, "content": db_plan.tips_content},
        "sections": db_plan.sections
    }

@router.get("/rehabilitation_plan/{patient_id}", response_model=PlanResponseModel)
def get_plan_by_patient_id(patient_id: str, db: Session = Depends(get_db)):
    plan = db.query(RehabilitationPlanDetails).filter_by(patient_id=patient_id).first()
    if not plan:
        raise HTTPException(status_code=404, detail="未找到康复方案")
    return {
        "title": plan.title,
        "tips": {"title": plan.tips_title, "content": plan.tips_content},
        "sections": plan.sections
    }

@router.get("/rehabilitation_plan", response_model=List[PlanResponseModel])
def get_all_plans(db: Session = Depends(get_db)):
    plans = db.query(RehabilitationPlanDetails).all()
    return [
        {
            "title": plan.title,
            "tips": {"title": plan.tips_title, "content": plan.tips_content},
            "sections": plan.sections
        }
        for plan in plans
    ]

@router.put("/rehabilitation_plan/{plan_id}", response_model=PlanResponseModel)
def update_plan(plan_id: int, plan: PlanUpdateModel, db: Session = Depends(get_db)):
    db_plan = db.query(RehabilitationPlanDetails).filter_by(id=plan_id).first()
    if not db_plan:
        raise HTTPException(status_code=404, detail="未找到康复方案")
    if plan.title is not None:
        db_plan.title = plan.title
    if plan.tips_title is not None:
        db_plan.tips_title = plan.tips_title
    if plan.tips_content is not None:
        db_plan.tips_content = plan.tips_content
    if plan.sections is not None:
        db_plan.sections = plan.sections
    db.commit()
    db.refresh(db_plan)
    return {
        "title": db_plan.title,
        "tips": {"title": db_plan.tips_title, "content": db_plan.tips_content},
        "sections": db_plan.sections
    }

@router.delete("/rehabilitation_plan/{plan_id}")
def delete_plan(plan_id: int, db: Session = Depends(get_db)):
    db_plan = db.query(RehabilitationPlanDetails).filter_by(id=plan_id).first()
    if not db_plan:
        raise HTTPException(status_code=404, detail="未找到康复方案")
    db.delete(db_plan)
    db.commit()
    return {"msg": "删除成功"} 