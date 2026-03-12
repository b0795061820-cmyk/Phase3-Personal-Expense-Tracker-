from sqlalchemy import Column, Integer, String, Float, ForeignKey, Date
from sqlalchemy.orm import relationship
import enum

from app.database import Base


# ================================
# User Roles
# ================================
class UserRole(str, enum.Enum):
    admin = "admin"
    user = "user"


# ================================
# Expense Categories
# ================================
class ExpenseCategory(str, enum.Enum):
    food = "food"
    transport = "transport"
    shopping = "shopping"
    bills = "bills"
    entertainment = "entertainment"


# ================================
# User Model
# ================================
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(String, nullable=False)

    email = Column(String, unique=True, index=True, nullable=False)

    hashed_password = Column(String, nullable=False)

    role = Column(String, default="user", nullable=False)

    expenses = relationship(
        "Expense",
        back_populates="owner",
        cascade="all, delete",
        lazy="joined"
    )


# ================================
# Expense Model
# ================================
class Expense(Base):
    __tablename__ = "expenses"

    id = Column(Integer, primary_key=True, index=True)

    title = Column(String, nullable=False)

    amount = Column(Float, nullable=False)

    # نخزنها كنص لتجنب مشاكل Enum مع FastAPI
    category = Column(String, nullable=False)

    description = Column(String, nullable=True)

    date = Column(Date, nullable=False)

    owner_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    owner = relationship(
        "User",
        back_populates="expenses"
    )