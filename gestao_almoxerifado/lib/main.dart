import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/chart.dart';
import 'package:gestao_almoxerifado/dashboardPage.dart';
import 'package:gestao_almoxerifado/models/dashboard_model.dart';
import 'package:gestao_almoxerifado/pages/config.dart';
import 'package:gestao_almoxerifado/pages/estoque.dart';
import 'package:gestao_almoxerifado/pages/login.dart';
import 'package:gestao_almoxerifado/pages/moviment.dart';
import 'components/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Raiz da aplicação
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão Almoxarifado',
      theme: ThemeData(
       //tema        
        colorScheme: .fromSeed(seedColor: Colors.green),
      ),
      //rotas
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => HomePage(),
        '/estoque': (context) => Estoque(),
        '/movimentacao': (context) => MovimentacaoPage(),
        '/configuracoes' : (context) => Configuracoes(),
      },
  
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    drawer: NavBar(),
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text('Almoxarifado')
    ),
    body: Center(
      child: Column(
        children: [
          Container(child: DashboardPage()),
          Text('Graficos: '),
          Container(child: Chart()),
        ],
      ),
    ),
    
   );
  }
}
