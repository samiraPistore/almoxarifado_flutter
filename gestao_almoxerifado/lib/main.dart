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
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light
          ),
          appBarTheme: const AppBarTheme(
          backgroundColor:Color.fromARGB(255, 8, 78, 11),
          foregroundColor: Colors.white, 
          iconTheme: IconThemeData(color: Colors.white),// Cor do texto/icones
        ),
      
      ),
      

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
            primary: const Color.fromARGB(255, 77, 180, 81),// Fundo mais escuro
            onSurface: Colors.white, // Texto claro para contraste),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 97, 229, 102),
          foregroundColor: Color.fromARGB(255, 30, 30, 30), 
          iconTheme: IconThemeData(color: Colors.black),// Cor do texto/icones no modo escuro
        ),
      ),
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
