import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import 'package:gestao_almoxerifado/components/user_form.dart';
import 'package:gestao_almoxerifado/components/user_list.dart';
import 'package:gestao_almoxerifado/models/users_model.dart';
import 'package:gestao_almoxerifado/services/user_service.dart';


class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}


class _ConfiguracoesState extends State<Configuracoes> {
  List<Users> users = [];

  void _addUser(Users user) async {
    final novo = await UserService.addUser(user);

    setState(() {
      users.add(novo);
    });
    Navigator.of(context).pop();
  }

   void _removeUser(String id) async{
    await UserService.deleteUser(id);
    setState(() {
      users.removeWhere((ur) => ur.id == id);
    });
  }

  //Função editar a produto com base no id
  void _editaUser(String id, String novoTitulo) {
    setState(() {
      final user = users.firstWhere((ur) => ur.id == id);
     user.nome = novoTitulo;
    });
  }


  @override

  void initState(){
    super.initState();
    _carregarUsers();
  }

  Future<void> _carregarUsers() async{
    final lista = await UserService.fetchUsers();
    setState(() {
      users = lista;
    });
  }
  Widget build(BuildContext context) {
 
    return Scaffold(
      drawer: NavBar(), //chama o menu do arquvo NavigatorBar.dart
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Configurações'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(child: UserForm(onSubmit: _addUser)),
            Expanded(child: UserList(users, _removeUser, _editaUser)),
          ],
        ),
      )
    
    );
  }
}