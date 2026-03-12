import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/expense_cubit.dart';

class AddExpensePage extends StatelessWidget {

  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {

    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final categoryController = TextEditingController();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Expense"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: "Amount"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                context.read<ExpenseCubit>().addExpense(

                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  category: categoryController.text,
                  date: DateTime.now().toString(),

                );

                Navigator.pop(context);

              },

              child: const Text("Add Expense"),

            )

          ],

        ),

      ),

    );

  }

}