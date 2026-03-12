import '../entities/expense_entity.dart';
import '../repositories/expense_repository.dart';

class GetExpenses {

  final ExpenseRepository repository;

  GetExpenses(this.repository);

  Future<List<ExpenseEntity>> call() {
    return repository.getExpenses();
  }

}