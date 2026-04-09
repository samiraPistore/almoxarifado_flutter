import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/dashboardList.dart';
import 'package:gestao_almoxerifado/models/dashboard_model.dart';
import 'package:gestao_almoxerifado/services/dashboard_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardModel? dashboard;

  @override
  void initState() {
    super.initState();
    _carregarIndic();
  }

  Future<void> _carregarIndic() async {
    final dados = await DashboardService.fetchIndic();
    setState(() {
      dashboard = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: dashboard == null
          ? Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 250),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : DashboardList(dashboard: dashboard!),
    );
  }
}
