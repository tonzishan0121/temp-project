from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Dict, Any
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, Integer, String, DECIMAL, JSON, SmallInteger

# ORM模型
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

class PhysiologicalRisks(Base):
    __tablename__ = "physiological_risks"
    id = Column(Integer, primary_key=True, autoincrement=True)
    patient_id = Column(String(20), unique=True, nullable=False)
    d_dimer = Column(DECIMAL(5, 2), nullable=False)
    d_dimer_suggestions = Column(JSON, nullable=False)
    nutrition_score = Column(SmallInteger, nullable=False)
    nutrition_suggestions = Column(JSON, nullable=False)
    blood_sugar = Column(DECIMAL(4, 1), nullable=False)
    blood_sugar_suggestions = Column(JSON, nullable=False)
    physiological_problems = Column(JSON, nullable=False)

# Pydantic模型
class RiskIndicatorsModel(BaseModel):
    dDimer: float
    dDimerSuggestions: List[str]
    nutritionScore: int
    nutritionSuggestions: List[str]
    bloodSugar: float
    bloodSugarSuggestions: List[str]

class PhysiologicalProblemModel(BaseModel):
    title: str

class PhysiologicalRisksResponseModel(BaseModel):
    physiological: List[PhysiologicalProblemModel]
    riskIndicators: RiskIndicatorsModel

router = APIRouter()

@router.get("/physiological_risks/patient/{patient_id}", response_model=PhysiologicalRisksResponseModel)
def get_physiological_risks_by_patient(patient_id: str, db: Session = Depends(get_db)):
    risk = db.query(PhysiologicalRisks).filter_by(patient_id=patient_id).first()
    if not risk:
        raise HTTPException(status_code=404, detail="未找到生理风险数据")
    # 处理JSON字段
    import json
    def ensure_list(val):
        if isinstance(val, str):
            return json.loads(val)
        return val
    physiological = [
        {"title": p} for p in ensure_list(risk.physiological_problems)
    ]
    riskIndicators = {
        "dDimer": float(risk.d_dimer),
        "dDimerSuggestions": ensure_list(risk.d_dimer_suggestions),
        "nutritionScore": int(risk.nutrition_score),
        "nutritionSuggestions": ensure_list(risk.nutrition_suggestions),
        "bloodSugar": float(risk.blood_sugar),
        "bloodSugarSuggestions": ensure_list(risk.blood_sugar_suggestions)
    }
    return {"physiological": physiological, "riskIndicators": riskIndicators}

__all__ = ["router", "PhysiologicalRisks"] 