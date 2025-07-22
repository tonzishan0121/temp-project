from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, Integer, String, DateTime, Numeric
from datetime import datetime

# ORM模型
class VitalSigns(Base):
    __tablename__ = "vital_signs"
    id = Column(Integer, primary_key=True, autoincrement=True)
    patient_id = Column(String(20))
    record_time = Column(DateTime)
    HR = Column(Integer)  # 心率
    SBP = Column(Integer)  # 收缩压
    ICP = Column(Integer)  # 颅内压
    MAP = Column(Integer)  # 平均动脉压
    temperature = Column(Numeric(3, 1))  # 体温
    RR = Column(Integer)  # 呼吸频率
    SpO2 = Column(Integer)  # 血氧饱和度
    PEEP = Column(Integer)  # 呼气末正压
    FiO2 = Column(Numeric(3, 2))  # 吸氧浓度

# Pydantic模型
class VitalSignsBase(BaseModel):
    patient_id: Optional[str] = None
    record_time: Optional[datetime] = None
    HR: Optional[int] = None
    SBP: Optional[int] = None
    ICP: Optional[int] = None
    MAP: Optional[int] = None
    temperature: Optional[float] = None
    RR: Optional[int] = None
    SpO2: Optional[int] = None
    PEEP: Optional[int] = None
    FiO2: Optional[float] = None

class VitalSignsCreate(VitalSignsBase):
    pass

class VitalSignsUpdate(VitalSignsBase):
    pass

class VitalSignsOut(VitalSignsBase):
    id: int
    class Config:
        orm_mode = True

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/vital_signs", response_model=List[VitalSignsOut])
def read_all_vital_signs(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """获取所有生命体征数据，支持分页。"""
    return db.query(VitalSigns).offset(skip).limit(limit).all()

@router.get("/vital_signs/{vital_signs_id}", response_model=VitalSignsOut)
def read_vital_signs(vital_signs_id: int, db: Session = Depends(get_db)):
    """根据id获取单个生命体征数据。"""
    vital_signs = db.query(VitalSigns).filter(VitalSigns.patient_id == vital_signs_id).first()
    if not vital_signs:
        raise HTTPException(status_code=404, detail="生命体征数据未找到")
    return vital_signs

@router.post("/vital_signs", response_model=VitalSignsOut)
def create_vital_signs(vital_signs: VitalSignsCreate, db: Session = Depends(get_db)):
    """创建新的生命体征数据。"""
    db_vital_signs = VitalSigns(**vital_signs.model_dump())
    db.add(db_vital_signs)
    try:
        db.commit()
        db.refresh(db_vital_signs)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"创建失败: {e}")
    return db_vital_signs

@router.put("/vital_signs/{vital_signs_id}", response_model=VitalSignsOut)
def update_vital_signs(vital_signs_id: int, vital_signs: VitalSignsUpdate, db: Session = Depends(get_db)):
    """根据id更新生命体征数据，支持部分字段。"""
    db_vital_signs = db.query(VitalSigns).filter(VitalSigns.patient_id == vital_signs_id).first()
    if not db_vital_signs:
        raise HTTPException(status_code=404, detail="生命体征数据未找到")
    for key, value in vital_signs.dict(exclude_unset=True).items():
        setattr(db_vital_signs, key, value)
    try:
        db.commit()
        db.refresh(db_vital_signs)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"更新失败: {e}")
    return db_vital_signs

@router.delete("/vital_signs/{vital_signs_id}")
def delete_vital_signs(vital_signs_id: int, db: Session = Depends(get_db)):
    """根据id删除生命体征数据。"""
    db_vital_signs = db.query(VitalSigns).filter(VitalSigns.patient_id == vital_signs_id).first()
    if not db_vital_signs:
        raise HTTPException(status_code=404, detail="生命体征数据未找到")
    db.delete(db_vital_signs)
    db.commit()
    return {"msg": "删除成功"}
