
import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/chart.dart';
import 'package:gestao_almoxerifado/components/dashboardList.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
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
    return Scaffold(
      drawer: NavBar(), //chama o menu do arquvo NavigatorBar.dart
      appBar: AppBar(
         leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
  
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
          
        ),
      ),
      body: dashboard == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Carregando dashboard...'),
                ],
              ),
            )
          : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DashboardList(dashboard: dashboard!),
                Chart(dashboard: dashboard)
              ],
            ),
          ),
    );
  }
}
