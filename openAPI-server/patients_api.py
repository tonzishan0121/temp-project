from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, String, Enum, Integer, SmallInteger, Date, func
from datetime import date

# ORM模型
class Patient(Base):
    __tablename__ = "patients"
    id = Column(String(20), primary_key=True, index=True)
    name = Column(String(50), nullable=False)
    gender = Column(Enum('男', '女'), nullable=False)
    age = Column(Integer, nullable=False)
    admission_date = Column(Date, nullable=False)
    department = Column(String(50), nullable=False)
    hospital_number = Column(String(50), nullable=False)
    attending_physician = Column(String(50), nullable=False)
    head_nurse = Column(String(50), nullable=False)
    diagnosis = Column(String(100), nullable=False)
    rehabilitation_doctor = Column(String(50), nullable=False)
    rehab_count = Column(SmallInteger, nullable=False, default=0)
    completion_rate = Column(Integer, nullable=False)
    physical_recovery = Column(Integer, nullable=False)
    NIHSS_score = Column(Integer, nullable=False)

# Pydantic模型
class PatientBase(BaseModel):
    name: str
    gender: str
    age: int
    admission_date: date
    department: str
    hospital_number: str
    attending_physician: str
    head_nurse: str
    diagnosis: str
    rehabilitation_doctor: str
    rehab_count: int
    completion_rate: int
    physical_recovery: int
    NIHSS_score: int

class PatientCreate(PatientBase):
    pass

class PatientUpdate(BaseModel):
    name: Optional[str]
    gender: Optional[str]
    age: Optional[int]
    admission_date: Optional[date]
    department: Optional[str]
    hospital_number: Optional[str]
    attending_physician: Optional[str]
    head_nurse: Optional[str]
    diagnosis: Optional[str]
    rehabilitation_doctor: Optional[str]
    rehab_count: Optional[int]
    completion_rate: Optional[int]
    physical_recovery: Optional[int]
    NIHSS_score: Optional[int]

class PatientOut(PatientBase):
    id: str

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/patients", response_model=List[PatientOut])
def read_patients(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """获取所有患者信息，支持分页。"""
    return db.query(Patient).offset(skip).limit(limit).all()

@router.get("/patients/{patient_id}", response_model=PatientOut)
def read_patient(patient_id: str, db: Session = Depends(get_db)):
    """根据id获取单个患者信息。"""
    patient = db.query(Patient).filter(Patient.id == patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="患者未找到")
    return patient

@router.post("/patients", response_model=PatientOut)
def create_patient(patient: PatientCreate, db: Session = Depends(get_db)):
    """创建新患者，id自动生成。"""
    max_id = db.query(func.max(Patient.id)).scalar()
    if max_id is None:
        new_id = "10000"
    else:
        try:
            new_id = str(int(max_id) + 1)
        except Exception:
            new_id = "10000"
    db_patient = Patient(id=new_id, **patient.model_dump())
    db.add(db_patient)
    try:
        db.commit()
        db.refresh(db_patient)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"创建失败: {e}")
    return db_patient

@router.put("/patients/{patient_id}", response_model=PatientOut)
def update_patient(patient_id: str, patient: PatientUpdate, db: Session = Depends(get_db)):
    """根据id更新患者信息，支持部分字段。"""
    db_patient = db.query(Patient).filter(Patient.id == patient_id).first()
    if not db_patient:
        raise HTTPException(status_code=404, detail="患者未找到")
    for key, value in patient.dict(exclude_unset=True).items():
        setattr(db_patient, key, value)
    try:
        db.commit()
        db.refresh(db_patient)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"更新失败: {e}")
    return db_patient

@router.delete("/patients/{patient_id}")
def delete_patient(patient_id: str, db: Session = Depends(get_db)):
    """根据id删除患者。"""
    db_patient = db.query(Patient).filter(Patient.id == patient_id).first()
    if not db_patient:
        raise HTTPException(status_code=404, detail="患者未找到")
    db.delete(db_patient)
    db.commit()
    return {"msg": "删除成功"} 