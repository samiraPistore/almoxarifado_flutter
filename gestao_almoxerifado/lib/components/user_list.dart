import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/produto.dart';
import 'package:gestao_almoxerifado/models/users.dart';

class UserList extends StatefulWidget {
  final List<Users> users;
  final void Function(String) onRemove;
  final void Function(String id, String novoUser) onEdit;

  //Construtor da lista
  const UserList(this.users, this.onRemove, this.onEdit, {Key? key})
    : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String? editandoId;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          widget
              .users
              .isEmpty //se lista estiver vazia mostra o texto "Nenhuma tarefa cadastrada"
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhum usuário cadastrado!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          //se não retorna as users
          : ListView.builder(
              itemCount: widget.users.length,
              itemBuilder: (ctx, index) {
                final ur = widget.users[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: editandoId == ur.id
                        ? TextField(
                            controller: controller,
                            onSubmitted: (value) {
                              widget.onEdit(ur.id, value);
                              setState(() {
                                editandoId = null;
                              });
                            },
                          )
                        : Text(
                          ur.nome,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Ocupa apenas o necessário
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),

                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => widget.onRemove(ur.id),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              if (editandoId == ur.id) {
                                widget.onEdit(ur.id, controller.text);
                                editandoId = null;
                              } else {
                                editandoId = ur.id;
                                controller.text = ur.nome;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}