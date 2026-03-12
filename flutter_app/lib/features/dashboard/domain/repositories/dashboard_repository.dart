import '../entities/dashboard_entity.dart';

abstract class DashboardRepository {

  Future<double> getTotalExpenses();

  Future<List<dynamic>> getExpensesByCategory();

  Future<List<dynamic>> getMonthlyExpenses();

}