import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

// AUTH
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';

// EXPENSES
import 'features/expenses/presentation/cubit/expense_cubit.dart';
import 'features/expenses/data/datasources/expense_remote_data_source.dart';
import 'features/expenses/data/repositories/expense_repository_impl.dart';
import 'features/expenses/domain/usecases/get_expenses.dart';
import 'features/expenses/domain/usecases/add_expense.dart';
import 'features/expenses/domain/usecases/delete_expense.dart';

// DASHBOARD
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    /// AUTH DEPENDENCIES
    final authRemote = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(authRemote);

    /// EXPENSE DEPENDENCIES
    final expenseRemote = ExpenseRemoteDataSource();
    final expenseRepository = ExpenseRepositoryImpl(expenseRemote);

    return MultiBlocProvider(

      providers: [

        /// AUTH CUBIT
        BlocProvider(
          create: (_) => AuthCubit(
            loginUseCase: LoginUseCase(authRepository),
            registerUseCase: RegisterUseCase(authRepository),
          ),
        ),

        /// EXPENSE CUBIT
        BlocProvider(
          create: (_) => ExpenseCubit(
            getExpensesUseCase: GetExpenses(expenseRepository),
            addExpenseUseCase: AddExpense(expenseRepository),
            deleteExpenseUseCase: DeleteExpense(expenseRepository),
          ),
        ),

        /// DASHBOARD CUBIT
        BlocProvider(
          create: (_) => DashboardCubit(),
        ),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        home: LoginPage(),
      ),

    );

  }

}