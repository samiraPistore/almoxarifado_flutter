import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/prodForm.dart';
import 'package:gestao_almoxerifado/components/NavigatorBar.dart';
import 'package:gestao_almoxerifado/models/produto.dart';
import 'package:gestao_almoxerifado/components/produtoList.dart';

class Estoque extends StatefulWidget {
  const Estoque({super.key});

  @override
  State<Estoque> createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  final List<Produto> produtos = [];

  void _addProduto(Produto produto) {
    setState(() {
      produtos.add(produto);
    });
    Navigator.of(context).pop();
  }

  void _removeProduto(String id) {
    setState(() {
      produtos.removeWhere((pr) => pr.id == id);
    });
  }

  //Função editar a produto com base no id
  void _editaProduto(String id, String novoTitulo) {
    setState(() {
      final produto = produtos.firstWhere((pr) => pr.id == id);
      produto.nome = novoTitulo;
    });
  }

  _openProdutoFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ProdutoForm(onSubmit: _addProduto);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), //chama o menu do arquvo NavigatorBar.dart
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Estoque'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Produtos em estoque: '),
          ),

          Expanded(
          
            child: ListaProdutos(produtos, _removeProduto, _editaProduto),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openProdutoFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
