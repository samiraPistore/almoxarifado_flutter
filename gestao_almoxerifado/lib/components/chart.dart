import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

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
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      title: 'test',
                      color: Colors.blue,
                    ),
                    PieChartSectionData(
                      value: 40,
                      title: 'test',
                      color: const Color.fromARGB(255, 30, 14, 81),
                    ),
                    PieChartSectionData(
                      value: 40,
                      title: 'test',
                      color: const Color.fromARGB(255, 89, 120, 48),
                    ),
                  ],
                ),
              ),
    
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}