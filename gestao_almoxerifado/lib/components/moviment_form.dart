import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/moviment.dart';
import 'package:gestao_almoxerifado/models/produto.dart';

class Movimentform extends StatefulWidget {
  final void Function(Movimentacao mov) onSubmit;
  final List<Produto> produtos;

  const Movimentform(this.onSubmit, this.produtos, {super.key});

  @override
  State<Movimentform> createState() => _MovimentformState();
}

class _MovimentformState extends State<Movimentform> {
  Produto? produtoSelecionado;

  final _tipoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _responsController = TextEditingController();
  final _obsController = TextEditingController();
  final _destinoController = TextEditingController();

  final DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final quantidade =
        int.tryParse(_quantidadeController.text) ?? 0;

    if (produtoSelecionado == null || quantidade <= 0) {
      return;
    }

    final novaMovimentacao = Movimentacao(
      id: DateTime.now().toString(),
      produtoId: produtoSelecionado!.id,
      tipo: _tipoController.text,
      quantidade: quantidade,
      data: _selectedDate,
      responsavel: _responsController.text,
      obs: _obsController.text,
      destino: _destinoController.text,
    );

    widget.onSubmit(novaMovimentacao);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<Produto>(
          hint: Text("Selecione um produto"),
          value: produtoSelecionado,
          items: widget.produtos.map((produto) {
            return DropdownMenuItem(
              value: produto,
              child: Text(produto.nome),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              produtoSelecionado = value;
            });
          },
        ),

        TextField(
          controller: _quantidadeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: "Quantidade"),
        ),

        ElevatedButton(
          onPressed: _submitForm,
          child: Text("Salvar"),
        ),
      ],
    );
  }
}