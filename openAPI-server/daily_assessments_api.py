from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, Integer, String, Date, SmallInteger
from datetime import date

# ORM模型
default_zero = lambda: 0
class DailyAssessment(Base):
    __tablename__ = "daily_assessments"
    id = Column(Integer, primary_key=True, autoincrement=True, index=True)
    patient_id = Column(String(20), nullable=False)
    assessment_date = Column(Date, nullable=False)
    S5Q = Column(SmallInteger, nullable=False)
    RASS = Column(SmallInteger, nullable=False)
    MMASA = Column(SmallInteger, nullable=False)
    MRCsum = Column(SmallInteger, nullable=False)
    BBS_sit_to_stand = Column(SmallInteger, nullable=False)
    BBS_standing = Column(SmallInteger, nullable=False)
    BBS_sitting = Column(SmallInteger, nullable=False)
    FOIS = Column(SmallInteger, nullable=False)

# Pydantic模型
class DailyAssessmentBase(BaseModel):
    patient_id: str
    assessment_date: date
    S5Q: int
    RASS: int
    MMASA: int
    MRCsum: int
    BBS_sit_to_stand: int
    BBS_standing: int
    BBS_sitting: int
    FOIS: int

class DailyAssessmentCreate(DailyAssessmentBase):
    pass

class DailyAssessmentUpdate(BaseModel):
    patient_id: Optional[str]
    assessment_date: Optional[date]
    S5Q: Optional[int]
    RASS: Optional[int]
    MMASA: Optional[int]
    MRCsum: Optional[int]
    BBS_sit_to_stand: Optional[int]
    BBS_standing: Optional[int]
    BBS_sitting: Optional[int]
    FOIS: Optional[int]

class DailyAssessmentOut(DailyAssessmentBase):
    id: int

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/daily_assessments", response_model=List[DailyAssessmentOut])
def read_daily_assessments(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(DailyAssessment).offset(skip).limit(limit).all()

@router.get("/daily_assessments/{assessment_id}", response_model=DailyAssessmentOut)
def read_daily_assessment(assessment_id: int, db: Session = Depends(get_db)):
    assessment = db.query(DailyAssessment).filter(DailyAssessment.patient_id == assessment_id).first()
    if not assessment:
        raise HTTPException(status_code=404, detail="评估记录未找到")
    return assessment

@router.post("/daily_assessments", response_model=DailyAssessmentOut)
def create_daily_assessment(assessment: DailyAssessmentCreate, db: Session = Depends(get_db)):
    db_assessment = DailyAssessment(**assessment.dict())
    db.add(db_assessment)
    try:
        db.commit()
        db.refresh(db_assessment)
    except Exception as e:
        db.rollback()
        print("插入错误：", e)
        raise HTTPException(status_code=400, detail=f"创建失败: {e}")
    return db_assessment

@router.put("/daily_assessments/{patient_id}", response_model=DailyAssessmentOut)
def update_daily_assessment(patient_id: str, assessment: DailyAssessmentUpdate, db: Session = Depends(get_db)):
    """根据patient_id更新该患者最新一条评估记录（按assessment_date最大）。"""
    db_assessment = db.query(DailyAssessment).filter(DailyAssessment.patient_id == patient_id).order_by(DailyAssessment.assessment_date.desc()).first()
    if not db_assessment:
        raise HTTPException(status_code=404, detail="评估记录未找到")
    for key, value in assessment.dict(exclude_unset=True).items():
        setattr(db_assessment, key, value)
    try:
        db.commit()
        db.refresh(db_assessment)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"更新失败: {e}")
    return db_assessment

@router.delete("/daily_assessments/{patient_id}")
def delete_daily_assessment(patient_id: int, db: Session = Depends(get_db)):
    db_assessment = db.query(DailyAssessment).filter(DailyAssessment.patient_id == patient_id).first()
    if not db_assessment:
        raise HTTPException(status_code=404, detail="评估记录未找到")
    db.delete(db_assessment)
    db.commit()
    return {"msg": "删除成功"} 