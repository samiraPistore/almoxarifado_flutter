import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/navigatorBar.dart';
import 'package:gestao_almoxerifado/components/userForm.dart';
import 'package:gestao_almoxerifado/models/users.dart';


class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}


class _ConfiguracoesState extends State<Configuracoes> {
  final List<Users> _users = [];

  _addUser(Users user) {
    setState(() {
      _users.add(user);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      drawer: NavBar(), //chama o menu do arquvo NavigatorBar.dart
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Configurações'),
      ),
      body: Container(
        child: UserForm(onSubmit: _addUser),
      )
    
    );
  }
}