import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<DashboardCubit>().loadDashboard();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Dashboard"),
      ),

      body: BlocBuilder<DashboardCubit, Map<String, dynamic>>(

        builder: (context, state) {

          if (state.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(

            children: [

              const SizedBox(height: 20),

              Text(
                "Total Expenses: ${state["total"]}",
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 30),

              const Text("Expenses by Category"),

              Expanded(
                child: ListView.builder(

                  itemCount: state["categories"].length,

                  itemBuilder: (context, index) {

                    final item = state["categories"][index];

                    return ListTile(
                      title: Text(item["category"]),
                      trailing: Text(item["total"].toString()),
                    );

                  },

                ),
              ),

            ],

          );

        },

      ),

    );

  }

}