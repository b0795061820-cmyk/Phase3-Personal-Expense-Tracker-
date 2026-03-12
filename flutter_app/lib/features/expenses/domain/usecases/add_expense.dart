import '../repositories/expense_repository.dart';

class AddExpense {

  final ExpenseRepository repository;

  AddExpense(this.repository);

  Future<void> call({
    required String title,
    required double amount,
    required String category,
    String? description,
    required String date,
  }) {

    return repository.addExpense(
      title: title,
      amount: amount,
      category: category,
      description: description,
      date: date,
    );

  }

}