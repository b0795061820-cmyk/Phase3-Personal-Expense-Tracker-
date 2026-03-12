import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_expenses.dart';
import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/delete_expense.dart';

import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {

  final GetExpenses getExpensesUseCase;
  final AddExpense addExpenseUseCase;
  final DeleteExpense deleteExpenseUseCase;

  ExpenseCubit({
    required this.getExpensesUseCase,
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
  }) : super(ExpenseInitial());

  Future<void> loadExpenses() async {

    emit(ExpenseLoading());

    try {

      final expenses = await getExpensesUseCase();

      emit(ExpenseLoaded(expenses));

    } catch (e) {

      emit(ExpenseError(e.toString()));

    }

  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    String? description,
    required String date,
  }) async {

    try {

      await addExpenseUseCase(
        title: title,
        amount: amount,
        category: category,
        description: description,
        date: date,
      );

      await loadExpenses();

    } catch (e) {

      emit(ExpenseError(e.toString()));

    }

  }

  Future<void> deleteExpense(int id) async {

    try {

      await deleteExpenseUseCase(id);

      await loadExpenses();

    } catch (e) {

      emit(ExpenseError(e.toString()));

    }

  }

}