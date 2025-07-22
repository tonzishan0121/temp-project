from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional, Dict, Any
from pydantic import BaseModel
from database import Base, SessionLocal
from sqlalchemy import Column, Integer, String, JSON

# ORM模型
class RehabilitationPathways(Base):
    __tablename__ = "rehabilitation_pathways"
    id = Column(Integer, primary_key=True, autoincrement=True)
    patient_id = Column(String(20))
    part = Column(Integer)  # 康复阶段(1-3)
    category = Column(String(50))  # 分类
    subcategory = Column(String(50))  # 子分类
    items = Column(JSON)  # 项目列表

# Pydantic模型
class RehabilitationPathwaysBase(BaseModel):
    patient_id: Optional[str] = None
    part: Optional[int] = None
    category: Optional[str] = None
    subcategory: Optional[str] = None
    items: Optional[list] = None

class RehabilitationPathwaysCreate(RehabilitationPathwaysBase):
    pass

class RehabilitationPathwaysUpdate(RehabilitationPathwaysBase):
    pass

class RehabilitationPathwaysOut(RehabilitationPathwaysBase):
    id: int
    class Config:
        orm_mode = True

# 新的响应模型 - 嵌套结构
class PathwayNestedResponse(BaseModel):
    part1: Optional[Dict[str, Dict[str, List[str]]]] = None
    part2: Optional[Dict[str, Dict[str, List[str]]]] = None
    part3: Optional[Dict[str, Dict[str, List[str]]]] = None

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def transform_to_nested_structure(pathways: List[RehabilitationPathways]) -> Dict[str, Any]:
    """将扁平化的康复路径数据转换为嵌套结构"""
    result = {}
    
    for pathway in pathways:
        part_key = f"part{pathway.part}"
        category = pathway.category
        subcategory = pathway.subcategory
        items = pathway.items if pathway.items else []
        
        if part_key not in result:
            result[part_key] = {}
        
        if category not in result[part_key]:
            result[part_key][category] = {}
        
        result[part_key][category][subcategory] = items
    
    return result

@router.get("/rehabilitation_pathways", response_model=List[RehabilitationPathwaysOut])
def read_all_pathways(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """获取所有康复路径数据，支持分页。"""
    return db.query(RehabilitationPathways).offset(skip).limit(limit).all()

@router.get("/rehabilitation_pathways/{pathway_id}", response_model=RehabilitationPathwaysOut)
def read_pathway(pathway_id: int, db: Session = Depends(get_db)):
    """根据id获取单个康复路径数据。"""
    pathway = db.query(RehabilitationPathways).filter(RehabilitationPathways.id == pathway_id).first()
    if not pathway:
        raise HTTPException(status_code=404, detail="康复路径数据未找到")
    return pathway

@router.get("/rehabilitation_pathways/patient/{patient_id}", response_model=Dict[str, Any])
def read_pathways_by_patient(patient_id: str, db: Session = Depends(get_db)):
    """根据患者ID获取该患者的康复路径数据，返回嵌套结构。"""
    pathways = db.query(RehabilitationPathways).filter(RehabilitationPathways.patient_id == patient_id).all()
    if not pathways:
        raise HTTPException(status_code=404, detail="该患者无康复路径数据")
    
    return transform_to_nested_structure(pathways)

@router.post("/rehabilitation_pathways", response_model=RehabilitationPathwaysOut)
def create_pathway(pathway: RehabilitationPathwaysCreate, db: Session = Depends(get_db)):
    """创建新的康复路径数据。"""
    db_pathway = RehabilitationPathways(**pathway.model_dump())
    db.add(db_pathway)
    try:
        db.commit()
        db.refresh(db_pathway)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"创建失败: {e}")
    return db_pathway

@router.put("/rehabilitation_pathways/{pathway_id}", response_model=RehabilitationPathwaysOut)
def update_pathway(pathway_id: int, pathway: RehabilitationPathwaysUpdate, db: Session = Depends(get_db)):
    """根据id更新康复路径数据，支持部分字段。"""
    db_pathway = db.query(RehabilitationPathways).filter(RehabilitationPathways.id == pathway_id).first()
    if not db_pathway:
        raise HTTPException(status_code=404, detail="康复路径数据未找到")
    for key, value in pathway.dict(exclude_unset=True).items():
        setattr(db_pathway, key, value)
    try:
        db.commit()
        db.refresh(db_pathway)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"更新失败: {e}")
    return db_pathway

@router.delete("/rehabilitation_pathways/{pathway_id}")
def delete_pathway(pathway_id: int, db: Session = Depends(get_db)):
    """根据id删除康复路径数据。"""
    db_pathway = db.query(RehabilitationPathways).filter(RehabilitationPathways.id == pathway_id).first()
    if not db_pathway:
        raise HTTPException(status_code=404, detail="康复路径数据未找到")
    db.delete(db_pathway)
    db.commit()
    return {"msg": "删除成功"}
