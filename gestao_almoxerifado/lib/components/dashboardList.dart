import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/dashboard_card.dart';
import 'package:gestao_almoxerifado/models/dashboard_model.dart';

class DashboardList extends StatelessWidget {
 final DashboardModel? dashboard;
  const DashboardList({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  DashboardCard(
                    titulo: 'Movimentações: ',
                    valor: dashboard!.totalMov.toString(),
                  ),
                  DashboardCard(
                    titulo: 'Total produtos: ',
                    valor: dashboard!.totalProd.toString(),
                  ),
                  DashboardCard(
                    titulo: 'Entradas: ',
                    valor: dashboard!.totalEntrada.toString(),
                  ),
                  DashboardCard(
                    titulo: 'Saídas: ',
                    valor: dashboard!.totalSaida.toString(),
                  ),
                  DashboardCard(
                    titulo: 'Estoque baixo',
                    valor: dashboard!.estoqueBaixo.toString(),
                  ),
                ],
              ),
            ],
            
          ),
        ),
      ),
      
    );
  }
}