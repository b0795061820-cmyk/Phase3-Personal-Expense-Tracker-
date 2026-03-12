import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_total_expenses.dart';
import '../../domain/usecases/get_category_expenses.dart';
import '../../domain/usecases/get_monthly_expenses.dart';

class DashboardCubit extends Cubit<Map<String, dynamic>> {

  final GetTotalExpenses getTotalExpenses;
  final GetCategoryExpenses getCategoryExpenses;
  final GetMonthlyExpenses getMonthlyExpenses;

  DashboardCubit({
    required this.getTotalExpenses,
    required this.getCategoryExpenses,
    required this.getMonthlyExpenses,
  }) : super({});

  Future<void> loadDashboard() async {

    final total = await getTotalExpenses();
    final categories = await getCategoryExpenses();
    final monthly = await getMonthlyExpenses();

    emit({
      "total": total,
      "categories": categories,
      "monthly": monthly,
    });

  }

}