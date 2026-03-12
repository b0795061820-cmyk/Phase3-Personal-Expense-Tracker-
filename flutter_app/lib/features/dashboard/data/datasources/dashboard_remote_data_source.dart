import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../injection_container.dart';

class DashboardRemoteDataSource {

  final Dio dio = sl<DioClient>().dio;

  Future<double> getTotalExpenses() async {

    final response = await dio.get(
      ApiConstants.totalExpenses,
    );

    return (response.data["total_expenses"] ?? 0).toDouble();

  }

  Future<List<dynamic>> getExpensesByCategory() async {

    final response = await dio.get(
      ApiConstants.expensesByCategory,
    );

    return response.data;

  }

  Future<List<dynamic>> getMonthlyExpenses() async {

    final response = await dio.get(
      ApiConstants.monthlyExpenses,
    );

    return response.data;

  }

}