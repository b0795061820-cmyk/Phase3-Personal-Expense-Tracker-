import '../entities/expense_entity.dart';

abstract class ExpenseRepository {

  Future<List<ExpenseEntity>> getExpenses();

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    String? description,
    required String date,
  });

  Future<void> deleteExpense(int id);

}