from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, String, Date, JSON
from datetime import date

# ORM模型
class BloodPressureMonitor(Base):
    __tablename__ = "blood_pressure_monitor"
    patient_id = Column(String(20), primary_key=True)
    record_date = Column(Date)
    heart_rate = Column(JSON)
    systolic_pressure = Column(JSON)
    diastolic_pressure = Column(JSON)

# Pydantic模型
class BloodPressureMonitorBase(BaseModel):
    record_date: Optional[date] = None
    heart_rate: Optional[list] = None
    systolic_pressure: Optional[list] = None
    diastolic_pressure: Optional[list] = None

class BloodPressureMonitorCreate(BloodPressureMonitorBase):
    patient_id: str

class BloodPressureMonitorUpdate(BloodPressureMonitorBase):
    pass

class BloodPressureMonitorOut(BloodPressureMonitorBase):
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

@router.get("/blood_pressure_monitor", response_model=List[BloodPressureMonitorOut])
def read_all_bpm(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(BloodPressureMonitor).offset(skip).limit(limit).all()

@router.get("/blood_pressure_monitor/{patient_id}", response_model=BloodPressureMonitorOut)
def read_bpm(patient_id: str, db: Session = Depends(get_db)):
    bpm = db.query(BloodPressureMonitor).filter(BloodPressureMonitor.patient_id == patient_id).first()
    if not bpm:
        raise HTTPException(status_code=404, detail="未找到血压监测数据")
    return bpm

@router.post("/blood_pressure_monitor", response_model=BloodPressureMonitorOut)
def create_bpm(bpm: BloodPressureMonitorCreate, db: Session = Depends(get_db)):
    db_bpm = BloodPressureMonitor(**bpm.model_dump())
    db.add(db_bpm)
    try:
        db.commit()
        db.refresh(db_bpm)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"创建失败: {e}")
    return db_bpm

@router.put("/blood_pressure_monitor/{patient_id}", response_model=BloodPressureMonitorOut)
def update_bpm(patient_id: str, bpm: BloodPressureMonitorUpdate, db: Session = Depends(get_db)):
    db_bpm = db.query(BloodPressureMonitor).filter(BloodPressureMonitor.patient_id == patient_id).first()
    if not db_bpm:
        raise HTTPException(status_code=404, detail="未找到血压监测数据")
    for key, value in bpm.dict(exclude_unset=True).items():
        setattr(db_bpm, key, value)
    try:
        db.commit()
        db.refresh(db_bpm)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"更新失败: {e}")
    return db_bpm

@router.delete("/blood_pressure_monitor/{patient_id}")
def delete_bpm(patient_id: str, db: Session = Depends(get_db)):
    db_bpm = db.query(BloodPressureMonitor).filter(BloodPressureMonitor.patient_id == patient_id).first()
    if not db_bpm:
        raise HTTPException(status_code=404, detail="未找到血压监测数据")
    db.delete(db_bpm)
    db.commit()
    return {"msg": "删除成功"}
