import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/moviment.dart';
import 'package:gestao_almoxerifado/models/produto.dart';
import 'package:gestao_almoxerifado/services/prod_services.dart';

class Movimentform extends StatefulWidget {
  final void Function(Movimentacao) onSubmit;
  final List<Movimentacao> movimentacoes;

  const Movimentform(this.onSubmit, this.movimentacoes, {Key? key})
    : super(key: key);

  @override
  State<Movimentform> createState() => _MovimentformState();
}

class _MovimentformState extends State<Movimentform> {
  List<Produto> produtos = [];
  Produto? produtoSelecionado;

  bool isEntrada = true;
  final _quantidadeController = TextEditingController();
  final _responsController = TextEditingController();
  final _obsController = TextEditingController();
  final _destinoController = TextEditingController();

  void _submitForm() {
    final quantidade = int.tryParse(_quantidadeController.text) ?? 0;
    final responsavel = _responsController.text;
    if (produtoSelecionado == null) {
      return;
    } else {
      widget.onSubmit(
        Movimentacao(
          id: Random().nextDouble().toString(),
          produtoId: produtoSelecionado!.id,
          tipo: isEntrada ? "entrada" : "saída",
          quantidade: int.parse(_quantidadeController.text),
          data: DateTime.now(),
          responsavel: _responsController.text,
          obs: _obsController.text,
          destino: isEntrada ? null : _destinoController.text,
        ),
      );
    }

    _quantidadeController.clear();
    _responsController.clear();
    _obsController.clear();
    _destinoController.clear();
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
        // 🔘 SELETOR
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: Text("Entrada"),
                value: true,
                groupValue: isEntrada,
                onChanged: (value) {
                  setState(() {
                    isEntrada = value!;
                    _destinoController.clear();
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: Text("Saída"),
                value: false,
                groupValue: isEntrada,
                onChanged: (value) {
                  setState(() {
                    isEntrada = value!;
                  });
                },
              ),
            ),
          ],
        ),

        // 📦 PRODUTO
        DropdownButtonFormField<Produto>(
          hint: Text("Selecione um produto"),
          value: produtoSelecionado,
          items: produtos.map((produto) {
            return DropdownMenuItem(value: produto, child: Text(produto.nome));
          }).toList(),
          onChanged: (value) {
            setState(() {
              produtoSelecionado = value;
            });
          },
        ),

        // 🔢 QUANTIDADE
        TextField(
          controller: _quantidadeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: "Quantidade"),
        ),

        // 👤 RESPONSÁVEL
        TextField(
          controller: _responsController,
          decoration: InputDecoration(labelText: "Responsável"),
        ),

        // 📝 OBS
        TextField(
          controller: _obsController,
          decoration: InputDecoration(labelText: "Observação"),
        ),

        // 🚚 DESTINO (SÓ NA SAÍDA)
        if (!isEntrada)
          TextField(
            controller: _destinoController,
            decoration: InputDecoration(labelText: "Destino"),
          ),

        const SizedBox(height: 10),

        ElevatedButton(onPressed: _submitForm, child: Text("Salvar")),
      ],
    );
  }
}
