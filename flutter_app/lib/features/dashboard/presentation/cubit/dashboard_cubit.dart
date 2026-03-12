import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {

  DashboardCubit() : super(DashboardInitial());

  Future<void> loadDashboard() async {

    emit(DashboardLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(
      DashboardLoaded(
        dashboard: {
          "total": 1200,
          "categories": [
            {"name": "Food", "amount": 400},
            {"name": "Transport", "amount": 300},
            {"name": "Shopping", "amount": 500},
          ]
        },
      ),
    );

  }
}