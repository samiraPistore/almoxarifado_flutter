import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/dashboard_card.dart';
import 'package:gestao_almoxerifado/models/dashboard_model.dart';

class DashboardList extends StatelessWidget {
 final DashboardModel? dashboard;
  const DashboardList({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                DashboardCard(
                  titulo: 'Movimentações: ',
                  valor: dashboard!.totalMov.toString(),
                ),
                DashboardCard(
                  titulo: 'Produtos Cadastrados: ',
                  valor: dashboard!.totalProd.toString(),
                ),
              ],
            ),
            Row(
              children: [
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
    );
  }
}
