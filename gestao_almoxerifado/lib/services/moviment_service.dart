import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/moviment.dart';

class MovimentService {
  static const String baseUrl = 'http://10.0.2.2:3001';

  static Future<List<Movimentacao>> fetchMovimentacao() async {
    final response = await http.get(Uri.parse('$baseUrl/movimentacoes'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Movimentacao.fromJson(e)).toList();
    } else {
      throw Exception('Ero ao buscar movimentações');
    }
  }

   //Adiconar
  static Future<Movimentacao> addMovimentacao(Movimentacao moviment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/movimentacoes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "id": moviment.id,
        "produtoId": moviment.produtoId,
        "tipo": moviment.tipo,
        "quantidade": moviment.quantidade,
        "data": moviment.data.toIso8601String(),
        "responsavel": moviment.responsavel,
        "obs": moviment.obs,
        "destino": moviment.destino,
      }),
    );

    if (response.statusCode == 200) {
      return Movimentacao.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao cadatrar movimentçãos');
    }
  }
}
