import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../injection_container.dart';

import '../models/expense_model.dart';

class ExpenseRemoteDataSource {

  final Dio dio = sl<DioClient>().dio;

  Future<List<ExpenseModel>> getExpenses() async {

    final response = await dio.get(
      ApiConstants.expenses,
    );

    final List data = response.data;

    return data.map((e) => ExpenseModel.fromJson(e)).toList();

  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    String? description,
    required String date,
  }) async {

    await dio.post(
      ApiConstants.expenses,
      data: {
        "title": title,
        "amount": amount,
        "category": category,
        "description": description,
        "date": date
      },
    );

  }

  Future<void> deleteExpense(int id) async {

    await dio.delete(
      "${ApiConstants.expenses}/$id",
    );

  }

}