import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produto.dart';

class ProdutoService {
  static const String baseUrl = 'http://10.0.2.2:3001';

  //Função pegar o produto
  static Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/produtos'),
    ); //faz a requisição

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Produto.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar produtos');
    }
  }

  //Função para criar produto
  static Future<Produto> addProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nome": produto.nome,
        "codigo": produto.codigo,
        "categoria": produto.categoria,
        "uniMedida": produto.uniMedida,
        "qtdMin": produto.qtdMin,
        "qtdAtual": produto.qtdAtual,
        "localEstoq": produto.localEstoq,
        "valorUni": produto.valorUni,
      }),
    );

    if (response.statusCode == 200) {
      return Produto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao adicionar produto');
    }
  }


  // Função para deletar produto
  static Future<void> deleteProduto(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/produtos/$id'));

    // Se não for sucesso, dá erro
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar');
    }
  }


  //
}
