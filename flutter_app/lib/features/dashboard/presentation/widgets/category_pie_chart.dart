import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryPieChart extends StatelessWidget {

  final List categories;

  const CategoryPieChart({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {

    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.purple,
    ];

    return PieChart(

      PieChartData(

        sections: List.generate(categories.length, (index) {

          final item = categories[index];

          return PieChartSectionData(

            value: (item["total"]).toDouble(),

            title: "${item["category"]}\n${item["total"]}",

            radius: 70,

            color: colors[index % colors.length],

            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),

          );

        }),

        sectionsSpace: 2,
        centerSpaceRadius: 40,

      ),

    );

  }

}