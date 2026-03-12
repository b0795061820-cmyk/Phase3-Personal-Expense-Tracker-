import '../../domain/repositories/dashboard_repository.dart';

import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {

  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<double> getTotalExpenses() {

    return remoteDataSource.getTotalExpenses();

  }

  @override
  Future<List<dynamic>> getExpensesByCategory() {

    return remoteDataSource.getExpensesByCategory();

  }

  @override
  Future<List<dynamic>> getMonthlyExpenses() {

    return remoteDataSource.getMonthlyExpenses();

  }

}