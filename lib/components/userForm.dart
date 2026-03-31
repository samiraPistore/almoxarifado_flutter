import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/users.dart';

class UserForm extends StatefulWidget {
  final void Function(Users) onSubmit;
  const UserForm({super.key, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _nomeUserController = TextEditingController();
  final _cargoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();


 _submitForm() {
    final nomeUser = _nomeUserController.text;
    final cargo = _cargoController.text;
    final email = _emailController.text;
    final senha = _senhaController.text;

    // validação simples
    if (nomeUser.isEmpty || cargo.isEmpty|| email.isEmpty || senha.isEmpty){
      return;
    }else{
       widget.onSubmit(Users(nome: nomeUser, cargo: cargo, email: email, senha: senha));
    }

    // limpa tudo
    _nomeUserController.clear();
    _cargoController.clear();
    _emailController.clear();
    _senhaController.clear();
  }
   
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nomeUserController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Nome do usuário'),
              ),
              TextField(
                controller: _cargoController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Cargo'),
              ),
              TextField(
                controller: _emailController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _senhaController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    child: Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 160, 243),
                      foregroundColor: const Color.fromARGB(255, 255, 254, 254)
                    ),
                   onPressed: _submitForm, 
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
