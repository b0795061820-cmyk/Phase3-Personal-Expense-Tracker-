import '../repositories/dashboard_repository.dart';

class GetMonthlyExpenses {

  final DashboardRepository repository;

  GetMonthlyExpenses(this.repository);

  Future<List<dynamic>> call() {
    return repository.getMonthlyExpenses();
  }

}