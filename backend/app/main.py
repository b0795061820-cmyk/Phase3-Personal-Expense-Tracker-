from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func, extract
from typing import List

from app.database import Base, engine, get_db
from app.models import User, Expense, ExpenseCategory
from app.schemas import (
    UserOut,
    UserRegister,
    UserLogin,
    TokenResponse,
    ExpenseCreate,
    ExpenseUpdate,
    ExpenseOut
)
from app.auth import (
    hash_password,
    verify_password,
    create_access_token,
    get_current_user,
    get_admin_user
)

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Expense Tracker API")


# ======================
# Home
# ======================
@app.get("/")
def home():
    return {"message": "API is running successfully"}


# ======================
# Register
# ======================
@app.post("/auth/register", response_model=UserOut)
def register(user: UserRegister, db: Session = Depends(get_db)):

    existing_user = db.query(User).filter(User.email == user.email).first()

    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    new_user = User(
        name=user.name,
        email=user.email,
        hashed_password=hash_password(user.password),
        role=user.role
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return new_user


# ======================
# Login
# ======================
@app.post("/auth/login", response_model=TokenResponse)
def login(user: UserLogin, db: Session = Depends(get_db)):

    db_user = db.query(User).filter(User.email == user.email).first()

    if not db_user:
        raise HTTPException(status_code=401, detail="Invalid email or password")

    if not verify_password(user.password, db_user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid email or password")

    token = create_access_token(data={"user_id": db_user.id})

    return {
        "access_token": token,
        "token_type": "bearer"
    }


# ======================
# Create Expense
# ======================
@app.post("/expenses", response_model=ExpenseOut)
def create_expense(
    expense: ExpenseCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    new_expense = Expense(
        title=expense.title,
        amount=expense.amount,
        category=expense.category,
        description=expense.description,
        date=expense.date,
        owner_id=current_user.id
    )

    db.add(new_expense)
    db.commit()
    db.refresh(new_expense)

    return new_expense


# ======================
# Get My Expenses
# ======================
@app.get("/expenses", response_model=List[ExpenseOut])
def get_my_expenses(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    expenses = db.query(Expense).filter(
        Expense.owner_id == current_user.id
    ).all()

    return expenses


# ======================
# Update Expense
# ======================
@app.put("/expenses/{expense_id}", response_model=ExpenseOut)
def update_expense(
    expense_id: int,
    expense: ExpenseUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    db_expense = db.query(Expense).filter(
        Expense.id == expense_id,
        Expense.owner_id == current_user.id
    ).first()

    if not db_expense:
        raise HTTPException(status_code=404, detail="Expense not found")

    if expense.title is not None:
        db_expense.title = expense.title

    if expense.amount is not None:
        db_expense.amount = expense.amount

    if expense.category is not None:
        db_expense.category = expense.category

    if expense.description is not None:
        db_expense.description = expense.description

    if expense.date is not None:
        db_expense.date = expense.date

    db.commit()
    db.refresh(db_expense)

    return db_expense


# ======================
# Delete Expense
# ======================
@app.delete("/expenses/{expense_id}")
def delete_expense(
    expense_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    db_expense = db.query(Expense).filter(
        Expense.id == expense_id,
        Expense.owner_id == current_user.id
    ).first()

    if not db_expense:
        raise HTTPException(status_code=404, detail="Expense not found")

    db.delete(db_expense)
    db.commit()

    return {"message": "Expense deleted successfully"}


# ======================
# Dashboard - Total Expenses
# ======================
@app.get("/dashboard/total-expenses")
def total_expenses(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    total = db.query(func.sum(Expense.amount)).filter(
        Expense.owner_id == current_user.id
    ).scalar()

    return {"total_expenses": total or 0}


# ======================
# Dashboard - Expenses by Category
# ======================
@app.get("/dashboard/expenses-by-category")
def expenses_by_category(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    results = db.query(
        Expense.category,
        func.sum(Expense.amount)
    ).filter(
        Expense.owner_id == current_user.id
    ).group_by(
        Expense.category
    ).all()

    data = []

    for category, total in results:
        data.append({
            "category": category,
            "total": total
        })

    return data


# ======================
# Dashboard - Monthly Expenses
# ======================
@app.get("/dashboard/monthly-expenses")
def monthly_expenses(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    results = db.query(
        extract("month", Expense.date).label("month"),
        func.sum(Expense.amount).label("total")
    ).filter(
        Expense.owner_id == current_user.id
    ).group_by(
        extract("month", Expense.date)
    ).order_by(
        extract("month", Expense.date)
    ).all()

    data = []

    for month, total in results:
        data.append({
            "month": int(month),
            "total": total
        })

    return data


# ======================
# Get Expense Categories
# ======================
@app.get("/categories")
def get_categories():

    categories = [category.value for category in ExpenseCategory]

    return {"categories": categories}


# ======================
# ADMIN - Get All Users
# ======================
@app.get("/admin/users", response_model=List[UserOut])
def get_all_users(
    db: Session = Depends(get_db),
    admin: User = Depends(get_admin_user)
):

    users = db.query(User).all()

    return users


# ======================
# ADMIN - Get All Expenses
# ======================
@app.get("/admin/all-expenses", response_model=List[ExpenseOut])
def get_all_expenses(
    db: Session = Depends(get_db),
    admin: User = Depends(get_admin_user)
):

    expenses = db.query(Expense).all()

    return expenses