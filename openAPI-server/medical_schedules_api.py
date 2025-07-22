from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
import json
from .database import SessionLocal, Base
from sqlalchemy import Column, Integer, String, Enum, JSON, DateTime

# ORM模型
class Doctor(Base):
    __tablename__ = "doctors"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    department = Column(Enum('理疗科','康复科','作业科','言语科','神经科','心理科','针灸科','推拿科'), nullable=False)
    today_schedule = Column(JSON, nullable=False, default=list)  # 存储当天排班小时数组

# Pydantic模型
class DoctorBase(BaseModel):
    name: str
    department: str

class DoctorOut(DoctorBase):
    id: int
    today_schedule: List[int]
    class Config:
        orm_mode = True

class AssignRequest(BaseModel):
    schedule: List[Optional[int]]  # 长度24，每个元素为医生id或None

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# 1. 获取当天有排班的医生
@router.get("/doctors/assigned", response_model=List[DoctorOut])
def get_assigned_doctors(db: Session = Depends(get_db)):
    """获取当天有排班的医生（today_schedule非空）。"""
    doctors = db.query(Doctor).filter(Doctor.today_schedule != []).all()
    return doctors

# 2. 获取全部医生
@router.get("/doctors/all", response_model=List[DoctorOut])
def get_all_doctors(db: Session = Depends(get_db)):
    """获取所有医生及其排班信息。"""
    doctors = db.query(Doctor).all()
    return doctors

# 3. 变更当天排班
@router.post("/doctors/assign")
def assign_doctors(req: AssignRequest, db: Session = Depends(get_db)):
    """重设当天24小时排班。传入长度24的数组，每个元素为医生id或None。"""
    if len(req.schedule) != 24:
        raise HTTPException(status_code=400, detail="排班数组长度必须为24")
    # 校验同一医生一天不能排多个小时
    doctor_ids = [i for i in req.schedule if i is not None]
    if len(doctor_ids) != len(set(doctor_ids)):
        raise HTTPException(status_code=400, detail="同一医生一天只能排一次班")
    # 先清空所有医生的today_schedule
    db.query(Doctor).update({Doctor.today_schedule: []})
    db.commit()
    # 遍历24小时，给每个医生today_schedule加上对应小时
    for hour, doctor_id in enumerate(req.schedule):
        if doctor_id is not None:
            doctor = db.query(Doctor).filter(Doctor.id == doctor_id).first()
            if doctor:
                schedule = doctor.today_schedule or []
                if isinstance(schedule, str):
                    schedule = json.loads(schedule)
                if hour not in schedule:
                    schedule.append(hour)
                    setattr(doctor, "today_schedule", schedule)
    db.commit()
    return {"msg": "排班成功"}
