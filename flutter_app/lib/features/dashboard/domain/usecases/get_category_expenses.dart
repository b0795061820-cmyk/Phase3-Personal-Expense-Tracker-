import '../repositories/dashboard_repository.dart';

class GetCategoryExpenses {

  final DashboardRepository repository;

  GetCategoryExpenses(this.repository);

  Future<List<dynamic>> call() {
    return repository.getExpensesByCategory();
  }

}