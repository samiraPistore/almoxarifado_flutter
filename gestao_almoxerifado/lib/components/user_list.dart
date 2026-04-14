import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/users_model.dart';

class UserList extends StatefulWidget {
  final List<Users> users;
  final void Function(String) onRemove;
  final void Function(Users userAtualizado) onEdit;

  const UserList(this.users, this.onRemove, this.onEdit, {super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  void _editaModalUser(Users ur) {
    final nomeController = TextEditingController(text: ur.nome);
    final cargoController = TextEditingController(text: ur.cargo);
    final emailController = TextEditingController(text: ur.email);
    final senhaController = TextEditingController(text: ur.senha);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Editar Usuário: ${ur.nome}'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: cargoController,
                  decoration: const InputDecoration(labelText: 'Cargo'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: senhaController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final atualizadoU = Users(
                  id: ur.id,
                  nome: nomeController.text,
                  cargo: cargoController.text,
                  email: emailController.text,
                  senha: senhaController.text,
                );

                widget.onEdit(atualizadoU);
                Navigator.pop(ctx);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.users.isEmpty) {
      return Center(
        child: Text(
          'Nenhum usuário cadastrado!',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (ctx, index) {
        final ur = widget.users[index];

        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TEXTO À ESQUERDA
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ur.nome.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Cargo: ${ur.cargo}'),
                      Text('Email: ${ur.email}'),
                      Text('Senha: ${ur.senha}'),
                    ],
                  ),
                ),

                // ÍCONES À DIREITA
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => _editaModalUser(ur),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => widget.onRemove(ur.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}