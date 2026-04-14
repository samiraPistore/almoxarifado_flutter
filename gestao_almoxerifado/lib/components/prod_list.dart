import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/produto_model.dart';

class ListaProdutos extends StatefulWidget {
  final List<Produto> produtos;
  final void Function(String) onRemove;
  final void Function(Produto prodAtualizado) onEdit;

  //Construtor da lista
  const ListaProdutos(this.produtos, this.onRemove, this.onEdit, {Key? key})
    : super(key: key);

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  void _editaModal(Produto pr) {
    final nomeController = TextEditingController(text: pr.nome);
    final codigoController = TextEditingController(text: pr.codigo);
    final categoriaController = TextEditingController(text: pr.categoria);
    final qtdMinController = TextEditingController(text: pr.qtdMin.toString());
    final qtdAtualController = TextEditingController(
      text: pr.qtdAtual.toString(),
    );
    final localController = TextEditingController(text: pr.localEstoq);
    final valorController = TextEditingController(text: pr.valorUni.toString());

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Editar produto: ${pr.nome}'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: codigoController,
                  decoration: const InputDecoration(labelText: 'Código'),
                ),
                TextField(
                  controller: categoriaController,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                TextField(
                  controller: qtdMinController,
                  decoration: const InputDecoration(labelText: 'Qtd Mínima'),
                ),
                TextField(
                  controller: qtdAtualController,
                  decoration: const InputDecoration(labelText: 'Qtd Atual'),
                ),
                TextField(
                  controller: localController,
                  decoration: const InputDecoration(labelText: 'Local'),
                ),
                TextField(
                  controller: valorController,
                  decoration: const InputDecoration(labelText: 'Valor'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(ctx),
            ),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                final atualizado = Produto(
                  id: pr.id,
                  nome: nomeController.text,
                  codigo: codigoController.text,
                  categoria: categoriaController.text,
                  qtdMin: int.parse(qtdMinController.text),
                  qtdAtual: int.parse(qtdAtualController.text),
                  localEstoq: localController.text,
                  valorUni: double.parse(valorController.text),
                );

                widget.onEdit(atualizado);

                Navigator.pop(ctx);
              },
            ),
          ],
        );
      },
    );
  }

  final color = const Color.fromARGB(255, 103, 103, 103);
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
                  'Nenhum Produto cadastrado!',
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
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pr.nome.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text('Código: ${pr.codigo}'),
                        Text('Categoria: ${pr.categoria}'),
                        Text('Qtd. Min: ${pr.qtdMin}'),
                        Text('Qtd. Atual: ${pr.qtdAtual}'),
                        Text('Local: ${pr.localEstoq}'),
                        Text('Valor uni.: ${pr.valorUni}'),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).colorScheme.error,
                              onPressed: () => widget.onRemove(pr.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                _editaModal(pr);
                              },
                            ),
                          ],
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
