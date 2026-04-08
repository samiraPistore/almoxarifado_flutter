import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/produto.dart';

class ListaProdutos extends StatefulWidget {
  final List<Produto> produtos;
  final void Function(String) onRemove;
  final void Function(String id, String novoTitle) onEdit;

  //Construtor da lista
  const ListaProdutos(this.produtos, this.onRemove, this.onEdit, {Key? key})
    : super(key: key);

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  String? editandoId;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          widget
              .produtos
              .isEmpty //se lista estiver vazia mostra o texto "Nenhuma tarefa cadastrada"
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhuma Produto cadastrada!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          //se não retorna as produtos
          : ListView.builder(
              itemCount: widget.produtos.length,
              itemBuilder: (ctx, index) {
                final pr = widget.produtos[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: editandoId == pr.id
                        ? TextField(
                            controller: controller,
                            onSubmitted: (value) {
                              widget.onEdit(pr.id, value);
                              setState(() {
                                editandoId = null;
                              });
                            },
                          )
                        : Text(
                          pr.nome,
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
                          onPressed: () => widget.onRemove(pr.id),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              if (editandoId == pr.id) {
                                widget.onEdit(pr.id, controller.text);
                                editandoId = null;
                              } else {
                                editandoId = pr.id;
                                controller.text = pr.nome;
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