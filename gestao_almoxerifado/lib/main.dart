import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/pages/dashboard_page.dart';
import 'package:gestao_almoxerifado/pages/config.dart';
import 'package:gestao_almoxerifado/pages/estoque_page..dart';
import 'package:gestao_almoxerifado/pages/login_page..dart';
import 'package:gestao_almoxerifado/pages/moviment_page..dart';
import 'package:gestao_almoxerifado/services/app.controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaAtual = Provider.of<AppController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestão Almoxarifado',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),

      darkTheme: ThemeData.dark(),
      themeMode: temaAtual.themeMode,

      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => DashboardPage(),
        '/estoque': (context) => Estoque(),
        '/movimentacao': (context) => MovimentacaoPage(),
        '/configuracoes': (context) => Configuracoes(),
      },
    );
  }
}
