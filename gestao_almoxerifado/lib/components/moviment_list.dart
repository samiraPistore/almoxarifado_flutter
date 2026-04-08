import 'package:flutter/material.dart';
import '../models/moviment.dart';

class ListaMoviment extends StatefulWidget {
  final List<Movimentacao> movimentacoes;

  const ListaMoviment(this.movimentacoes, {super.key});

  @override
  State<ListaMoviment> createState() => _ListaMovimentState();
}

class _ListaMovimentState extends State<ListaMoviment> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: widget.movimentacoes.isEmpty
          ? Column(
              children: const [
                SizedBox(height: 20),
                Text('Nenhuma movimentação registrada'),
              ],
            )
          : ListView.builder(
              itemCount: widget.movimentacoes.length,
              itemBuilder: (ctx, index) {
                final mov = widget.movimentacoes[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      mov.tipo.toUpperCase(),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantidade: ${mov.quantidade}"),
                        Text("Responsável: ${mov.responsavel}"),
                        Text("Data: ${mov.data}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}