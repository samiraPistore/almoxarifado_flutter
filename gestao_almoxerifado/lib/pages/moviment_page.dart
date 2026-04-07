import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/moviment_form.dart';
import 'package:gestao_almoxerifado/components/moviment_list.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import 'package:gestao_almoxerifado/services/moviment_service.dart';
import '../models/moviment.dart';


class MovimentacaoPage extends StatefulWidget {
  const MovimentacaoPage({super.key});

  @override
  State<MovimentacaoPage> createState() => _MovimentacaoPageState();
}

class _MovimentacaoPageState extends State<MovimentacaoPage> {
  List<Movimentacao> movimentacoes = [];

 void _addMoviment(Movimentacao movimentacao) async {
    await MovimentService.addMovimentacao(movimentacao);

    setState(() {
      movimentacoes.add(movimentacao);
    });
  }

  @override

  void initState(){
    super.initState();
    _carregarMovi();
  }

  Future<void> _carregarMovi() async{
    final lista = await MovimentService.fetchMovimentacao();
    setState(() {
      movimentacoes = lista;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Movimentação de Estoque")
        ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Movimentform(_addMoviment, movimentacoes),
            // HISTÓRICO
           Text("Histórico:"),
            Expanded(child: ListaMoviment(movimentacoes)),
          ],
        ),
      ),
    );
  }
}