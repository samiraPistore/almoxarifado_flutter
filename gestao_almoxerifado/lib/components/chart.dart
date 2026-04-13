import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/dashboard_model.dart';

class Chart extends StatelessWidget {
  final DashboardModel? dashboard;
  const Chart({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Defina a altura desejada
      width: 300,
      child: Card(
        child: Column(
          children: [
            Text('Entradas e Saídas'),
            SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        ),
                      
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: dashboard!.totalEntrada.toDouble(),
                          color: Colors.green,
                          width: 52,
                          borderRadius: BorderRadius.zero, 
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: dashboard!.totalSaida.toDouble(),
                          color: const Color.fromARGB(255, 2, 59, 4),
                          width:52,
                          borderRadius: BorderRadius.zero, 
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 5),
                Text("Entrada"),

                SizedBox(width: 20),

                Icon(Icons.circle, color: const Color.fromARGB(255, 2, 59, 4), size: 12),
                SizedBox(width: 5),
                Text("Saída"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
