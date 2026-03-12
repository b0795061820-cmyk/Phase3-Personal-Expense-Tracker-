import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),

      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {

          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DashboardLoaded) {

            final data = state.dashboard;

            final total = data["total"];
            final categories = data["categories"] as List;

            return Column(
              children: [

                const SizedBox(height: 20),

                const Text(
                  "Total Expenses",
                  style: TextStyle(fontSize: 20),
                ),

                Text(
                  "$total",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: categories.map((e) {
                        return PieChartSectionData(
                          value: (e["amount"] as num).toDouble(),
                          title: e["name"],
                          radius: 80,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text("No Data"),
          );
        },
      ),
    );
  }
}