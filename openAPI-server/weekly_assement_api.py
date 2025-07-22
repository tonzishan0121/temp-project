from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, String, Date, JSON, Integer
from datetime import date

# ORM模型
class WeeklyAssessment(Base):
    __tablename__ = "weekly_assessments"
    patient_id = Column(String(20), primary_key=True)
    week_start = Column(Date)
    SQ5 = Column(JSON)
    MRC = Column(JSON)
    FOIS = Column(JSON)
    RASS = Column(JSON)
    MMASA = Column(JSON)
    BBS1 = Column(JSON)
    BBS2 = Column(JSON)
    BBS3 = Column(JSON)

# Pydantic模型
class WeeklyAssessmentBase(BaseModel):
    week_start: Optional[date] = None
    SQ5: Optional[list] = None
    MRC: Optional[list] = None
    FOIS: Optional[list] = None
    RASS: Optional[list] = None
    MMASA: Optional[list] = None
    BBS1: Optional[list] = None
    BBS2: Optional[list] = None
    BBS3: Optional[list] = None

class WeeklyAssessmentCreate(WeeklyAssessmentBase):
    patient_id: str

class WeeklyAssessmentUpdate(WeeklyAssessmentBase):
    pass

class WeeklyAssessmentOut(WeeklyAssessmentBase):
    patient_id: str
    class Config:
        orm_mode = True

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/weekly_assessments", response_model=List[WeeklyAssessmentOut])
def read_all_weekly_assessments(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(WeeklyAssessment).offset(skip).limit(limit).all()

@router.get("/weekly_assessments/{patient_id}", response_model=WeeklyAssessmentOut)
def read_weekly_assessment(patient_id: str, db: Session = Depends(get_db)):
    assessment = db.query(WeeklyAssessment).filter(WeeklyAssessment.patient_id == patient_id).first()
    if not assessment:
        raise HTTPException(status_code=404, detail="未找到周评估数据")
    return assessment



@router.post("/weekly_assessments", response_model=WeeklyAssessmentOut)
def create_weekly_assessment(assessment: WeeklyAssessmentCreate, db: Session = Depends(get_db)):
    db_assessment = WeeklyAssessment(**assessment.model_dump())
    db.add(db_assessment)
    try:
        db.commit()
        db.refresh(db_assessment)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"创建失败: {e}")
    return db_assessment

@router.put("/weekly_assessments/{patient_id}", response_model=WeeklyAssessmentOut)
def update_weekly_assessment(patient_id: str, assessment: WeeklyAssessmentUpdate, db: Session = Depends(get_db)):
    db_assessment = db.query(WeeklyAssessment).filter(WeeklyAssessment.patient_id == patient_id).first()
    if not db_assessment:
        raise HTTPException(status_code=404, detail="未找到周评估数据")
    for key, value in assessment.dict(exclude_unset=True).items():
        setattr(db_assessment, key, value)
    try:
        db.commit()
        db.refresh(db_assessment)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"更新失败: {e}")
    return db_assessment

@router.delete("/weekly_assessments/{patient_id}")
def delete_weekly_assessment(patient_id: str, db: Session = Depends(get_db)):
    db_assessment = db.query(WeeklyAssessment).filter(WeeklyAssessment.patient_id == patient_id).first()
    if not db_assessment:
        raise HTTPException(status_code=404, detail="未找到周评估数据")
    db.delete(db_assessment)
    db.commit()
    return {"msg": "删除成功"}
