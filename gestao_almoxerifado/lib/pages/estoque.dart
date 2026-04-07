import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/prod_form.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import 'package:gestao_almoxerifado/models/produto.dart';
import 'package:gestao_almoxerifado/components/prod_list.dart';
import 'package:gestao_almoxerifado/services/prod_services.dart';

class Estoque extends StatefulWidget {
  const Estoque({super.key});

  @override
  State<Estoque> createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  List<Produto> produtos = [];

  void _addProduto(Produto produto) async {
    final novo = await ProdutoService.addProduto(produto);

    setState(() {
      produtos.add(novo);
    });
    Navigator.of(context).pop();
  }

  void _removeProduto(String id) async{
    await ProdutoService.deleteProduto(id);
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

  void _openProdutoFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ProdutoForm(onSubmit: _addProduto);
      },
    );
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
