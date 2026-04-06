import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/prod_form.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import 'package:gestao_almoxerifado/models/produto.dart';
import 'package:gestao_almoxerifado/components/prod_list.dart';
import 'dart:convert';
import  'package:http/http.dart'  as http;

class Estoque extends StatefulWidget {
  const Estoque({super.key});

  @override
  State<Estoque> createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  List<Produto> produtos = [];

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

  void initState(){
    super .initState();
    _fetchProdutos();
  }
  Future<void> _fetchProdutos() async{
    final response = await http.get(Uri.parse('http://10.196.200.12:3001/produtos'));
    if(response.statusCode == 200){
      final List<dynamic> json = jsonDecode(response.body);
      setState(() {
          produtos = json.map((item) => Produto.fromJson(item)).toList(); } 
      ); 
      // ignore: avoid_print
      print('Funcionou');
    } else { 
      throw Exception( 'Falha ao carregar produtos' );     
    }   
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
