import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/models/produto.dart';

class ProdutoForm extends StatefulWidget {
  final void Function(Produto) onSubmit;
  const ProdutoForm({super.key, required this.onSubmit});

  @override
  State<ProdutoForm> createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final _nomeController = TextEditingController();
  final _codigoController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _uniMedidaController = TextEditingController();
  final _qtdMinController = TextEditingController();
  final _qtdAtualController = TextEditingController();
  final _localController = TextEditingController();
  final _valorController = TextEditingController();

 _submitForm() {
    final nome = _nomeController.text;
    final qtd = int.tryParse(_qtdMinController.text) ?? 0;
    final valor = double.tryParse(_valorController.text) ?? 0;

    // validação simples
    if (nome.isEmpty || qtd <= 0 || valor <= 0) return;

    widget.onSubmit(
      Produto(
        id: Random().nextDouble().toString(),
        nome: _nomeController.text,
        codigo: _codigoController.text,
        categotia: _categoriaController.text,
        uniMedida: _uniMedidaController.text,
        qtdMin: int.tryParse(_qtdMinController.text) ?? 0,
        qtdAtual: int.tryParse(_qtdAtualController.text) ?? 0,
        localEstoq: _localController.text,
        valorUni: double.tryParse(_valorController.text) ?? 0,
      ),
    );

    // limpa tudo
    _nomeController.clear();
    _codigoController.clear();
    _categoriaController.clear();
    _uniMedidaController.clear();
    _qtdMinController.clear();
    _qtdAtualController.clear();
    _localController.clear();
    _valorController.clear();
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
                controller: _nomeController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Nome do produto'),
              ),
              TextField(
                controller: _codigoController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Código'),
              ),
              TextField(
                controller: _categoriaController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Categoria'),
              ),
              TextField(
                controller: _uniMedidaController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Unidade de medida',
                ),
              ),
              TextField(
                controller: _qtdMinController,
  
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Quantidade mínima',
                ),
              ),
              TextField(
                controller: _qtdAtualController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Quantidade atual',
                ),
              ),
              TextField(
                controller: _localController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Local no estoque',
                ),
              ),
              TextField(
                controller: _valorController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Valor unitário'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    child: Text('Nova Tarefa'),
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
