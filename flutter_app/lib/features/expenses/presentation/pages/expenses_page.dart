import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/expense_cubit.dart';
import '../cubit/expense_state.dart';

import 'add_expense_page.dart';

class ExpensesPage extends StatelessWidget {

  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<ExpenseCubit>().loadExpenses();

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Expenses"),
      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddExpensePage(),
            ),
          );

        },

      ),

      body: BlocBuilder<ExpenseCubit, ExpenseState>(

        builder: (context, state) {

          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ExpenseLoaded) {

            return ListView.builder(

              itemCount: state.expenses.length,

              itemBuilder: (context, index) {

                final expense = state.expenses[index];

                return ListTile(

                  title: Text(expense.title),

                  subtitle: Text("${expense.category} - ${expense.amount}"),

                  trailing: IconButton(

                    icon: const Icon(Icons.delete),

                    onPressed: () {

                      context.read<ExpenseCubit>().deleteExpense(expense.id);

                    },

                  ),

                );

              },

            );

          }

          if (state is ExpenseError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();

        },

      ),

    );

  }

}