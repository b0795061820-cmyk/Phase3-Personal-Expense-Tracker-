import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';

import '../datasources/expense_remote_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {

  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ExpenseEntity>> getExpenses() {

    return remoteDataSource.getExpenses();

  }

  @override
  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    String? description,
    required String date,
  }) {

    return remoteDataSource.addExpense(
      title: title,
      amount: amount,
      category: category,
      description: description,
      date: date,
    );

  }

  @override
  Future<void> deleteExpense(int id) {

    return remoteDataSource.deleteExpense(id);

  }

}