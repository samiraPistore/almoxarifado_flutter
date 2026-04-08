import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/moviment_form.dart';
import 'package:gestao_almoxerifado/components/moviment_list.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import 'package:gestao_almoxerifado/services/moviment_service.dart';
import '../models/moviment.dart';

//Página de movimentação
class MovimentacaoPage extends StatefulWidget {
  const MovimentacaoPage({super.key});

  @override
  State<MovimentacaoPage> createState() => _MovimentacaoPageState();
}

class _MovimentacaoPageState extends State<MovimentacaoPage> {
  //lista que uardda as movimentações
  List<Movimentacao> movimentacoes = [];

 //Função para adiconar movimentação
 void _addMoviment(Movimentacao movimentacao) async {
  //chama o serviço para salvar no backend
    await MovimentService.addMovimentacao(movimentacao);
    setState(() {
      movimentacoes.add(movimentacao);
    });
  }



  @override
  void initState(){
    super.initState();
    //Carregar dados ao iniciar tela
    _carregarMovi();
  }

  //Função que busca as movimentaçoes no backend
  Future<void> _carregarMovi() async {
  try {
    print("Buscando movimentações...");

    final lista = await MovimentService.fetchMovimentacao();

    print("Dados recebidos: $lista");

    setState(() {
      movimentacoes = lista;
    });

  } catch (e) {
    print("ERRO AO BUSCAR: $e");
  }
}

  @override
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
            //Form para adiciionar movimentações
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