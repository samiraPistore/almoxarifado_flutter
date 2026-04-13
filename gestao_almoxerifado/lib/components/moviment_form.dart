import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/moviment_model.dart';
import 'package:gestao_almoxerifado/models/produto_model.dart';
import 'package:gestao_almoxerifado/services/prod_services.dart';

class Movimentform extends StatefulWidget {
  final void Function(Movimentacao) onSubmit;
  final List<Movimentacao> movimentacoes;

  const Movimentform(this.onSubmit, this.movimentacoes, {super.key});

  @override
  State<Movimentform> createState() => _MovimentformState();
}

class _MovimentformState extends State<Movimentform> {
  List<Produto> produtos = [];
  Produto? produtoSelecionado;

  List<String> tipos = ['entrada', 'saída'];
  String? tipoMovimentcao;

  final _quantidadeController = TextEditingController();
  final _responsController = TextEditingController();
  final _obsController = TextEditingController();
  final _destinoController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    if (produtoSelecionado == null) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos')));
    } else {
      widget.onSubmit(
        Movimentacao(
          id: Random().nextDouble().toString(),
          produtoId: produtoSelecionado!.id,
          tipo: tipoMovimentcao ?? "entrada",
          quantidade: int.parse(_quantidadeController.text),
          data: _selectedDate,
          responsavel: _responsController.text,
          obs: _obsController.text,
          destino: tipoMovimentcao == 'entrada'
              ? null
              : _destinoController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Movimentação realizada com sucesso')));
    }

    _quantidadeController.clear();
    _responsController.clear();
    _obsController.clear();
    _destinoController.clear();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return print('Error');
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    final lista = await ProdutoService.fetchProdutos();

    setState(() {
      produtos = lista;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          hint: Text("Selecione o tipo de movimentação:"),
          initialValue: tipoMovimentcao,

          items: tipos.map((tipo) {
            return DropdownMenuItem<String>(value: tipo, child: Text(tipo));
          }).toList(),
          onChanged: (value) {
            setState(() {
              tipoMovimentcao = value;

              _destinoController.clear();

              if (tipoMovimentcao == 'entrada') {
                print('entrada selecionada');
              } else {
                print('saida selecionada');
              }
            });
          },
        ),
        // PRODUTO
        DropdownButtonFormField<Produto>(
          hint: Text("Selecione um produto:"),
          initialValue: produtoSelecionado,
          items: produtos.map((produto) {
            return DropdownMenuItem(value: produto, child: Text(produto.nome));
          }).toList(),
          onChanged: (value) {
            setState(() {
              produtoSelecionado = value;
            });
          },
        ),

        //Quantidade
        TextField(
          controller: _quantidadeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: "Quantidade"),
        ),

        //Responsável
        TextField(
          controller: _responsController,
          decoration: InputDecoration(labelText: "Responsável"),
        ),

        //Obs
        TextField(
          controller: _obsController,
          decoration: InputDecoration(labelText: "Observação"),
        ),

        // Mostrar destino apenas na saída
        if (tipoMovimentcao == 'saída')
          TextField(
            controller: _destinoController,
            decoration: InputDecoration(labelText: "Destino"),
          ),
        SizedBox(
              height: 70,
              child: Row(
                children: <Widget> [
                  Expanded(
                    child: Text(
                       'Data Selecionada: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'
                      ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text('Selecionar Data'), 
                    ),
                ],
              ),
            ),
        const SizedBox(height: 10),

        ElevatedButton(
          child: Text("Salvar"),
           style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
          ), 
          onPressed: _submitForm, 
        ),
      ],
    );
  }
}
