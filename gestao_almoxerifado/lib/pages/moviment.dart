import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/nav_bar.dart';
import '../models/moviment.dart';


class MovimentacaoPage extends StatefulWidget {
  const MovimentacaoPage({super.key});

  @override
  State<MovimentacaoPage> createState() => _MovimentacaoPageState();
}

class _MovimentacaoPageState extends State<MovimentacaoPage> {
  bool isEntrada = true;

  final quantidadeController = TextEditingController();
  final responsavelController = TextEditingController();
  final observacaoController = TextEditingController();
  final destinoController = TextEditingController();

  void salvar() {
    final mov = Movimentacao(
      id: DateTime.now().toString(),
      produtoId: "1",
      tipo: isEntrada ? "entrada" : "saida",
      quantidade: int.parse(quantidadeController.text),
      data: DateTime.now(),
      responsavel: responsavelController.text,
      obs: observacaoController.text,
      destino: isEntrada ? null : destinoController.text,
    );

    
   
    setState(() {
      quantidadeController.clear();
      responsavelController.clear();
      observacaoController.clear();
      destinoController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${mov.tipo} registrada!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: const Text("Movimentação de Estoque")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TOGGLE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => isEntrada = true),
                  child: const Text("Entrada"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() => isEntrada = false),
                  child: const Text("Saída"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              isEntrada ? "Entrada de Produtos" : "Saída de Produtos",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            // QUANTIDADE
            TextField(
              controller: quantidadeController,
              decoration: InputDecoration(
                labelText: isEntrada
                    ? "Quantidade recebida"
                    : "Quantidade retirada",
              ),
              keyboardType: TextInputType.number,
            ),

            // RESPONSÁVEL
            TextField(
              controller: responsavelController,
              decoration:
                  const InputDecoration(labelText: "Responsável"),
            ),

            // DESTINO (só saída)
            if (!isEntrada)
              TextField(
                controller: destinoController,
                decoration: const InputDecoration(
                    labelText: "Destino / Setor"),
              ),

            // OBSERVAÇÃO
            TextField(
              controller: observacaoController,
              decoration:
                  const InputDecoration(labelText: "Observação"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: salvar,
              child: const Text("Salvar"),
            ),

            const SizedBox(height: 20),

            // INFO ESTOQUE
            Text(
              "Quantidade atual:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // HISTÓRICO
            const Text("Histórico:"),

          ],
        ),
      ),
    );
  }
}