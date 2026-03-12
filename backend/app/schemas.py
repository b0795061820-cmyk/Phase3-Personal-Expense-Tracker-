from pydantic import BaseModel, EmailStr
from datetime import date
from typing import Optional
from enum import Enum


# =============================
# Expense Categories
# =============================
class ExpenseCategory(str, Enum):
    food = "food"
    transport = "transport"
    shopping = "shopping"
    bills = "bills"
    entertainment = "entertainment"


# =============================
# Register
# =============================
class UserRegister(BaseModel):
    name: str
    email: EmailStr
    password: str
    role: str = "user"


# =============================
# User Response
# =============================
class UserOut(BaseModel):
    id: int
    name: str
    email: EmailStr
    role: str

    class Config:
        orm_mode = True


# =============================
# Login
# =============================
class UserLogin(BaseModel):
    email: EmailStr
    password: str


# =============================
# Token
# =============================
class TokenResponse(BaseModel):
    access_token: str
    token_type: str


# =============================
# Expense Schemas
# =============================

# إنشاء مصروف
class ExpenseCreate(BaseModel):
    title: str
    amount: float
    category: ExpenseCategory
    description: Optional[str] = None
    date: date


# تعديل مصروف
class ExpenseUpdate(BaseModel):
    title: Optional[str] = None
    amount: Optional[float] = None
    category: Optional[ExpenseCategory] = None
    description: Optional[str] = None
    date: Optional[date] = None


# إرجاع المصروف
class ExpenseOut(BaseModel):
    id: int
    title: str
    amount: float
    category: ExpenseCategory
    description: Optional[str] = None
    date: date
    owner_id: int

    class Config:
        orm_mode = True