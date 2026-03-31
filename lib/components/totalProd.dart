// ignore: file_names
import 'package:flutter/material.dart';

class CardTotal extends StatelessWidget {
  final int totalProdutos;

  const CardTotal({super.key, required this.totalProdutos});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Qtd. produtos cadastrados: $totalProdutos'),
      ),
    );
  }
}