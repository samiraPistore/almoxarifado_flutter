import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import 'package:gestao_almoxerifado/pages/users_page.dart';
import 'package:gestao_almoxerifado/services/app.controller.dart';
import 'package:provider/provider.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<AppController>(context);

    return Scaffold(
      drawer: NavBar(),
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
          'Configurações',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person),
                  TextButton(
                  
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UsersPage()),
                      );
                    },
                    child: const Text("Ir para Usuários"),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.dark_mode),
                  const Text('Alterar tema: '),
                  Switch(
  
                    value:themeProvider.isDarkTheme,
                    onChanged: (value) {
                      themeProvider.changeTheme();
                    },
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
