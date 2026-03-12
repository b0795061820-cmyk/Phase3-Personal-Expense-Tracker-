import '../repositories/dashboard_repository.dart';

class GetTotalExpenses {

  final DashboardRepository repository;

  GetTotalExpenses(this.repository);

  Future<double> call() {
    return repository.getTotalExpenses();
  }

}