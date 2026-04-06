import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/total_prod.dart';
import 'package:gestao_almoxerifado/models/produto.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Produto> produtos = [];
  @override
  Widget build(BuildContext context) {
    return Column(
  children: [
    Row(
      children: [
        Expanded(child: CardTotal(totalProdutos: produtos.length )),
        Expanded(child: CardTotal(totalProdutos: produtos.length )),
        Expanded(child: CardTotal(totalProdutos: produtos.length )),
        Expanded(child: CardTotal(totalProdutos: produtos.length )),
       
      ],
    ),
  ],
);
  }
}