import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/users.dart';

class UserService {
  static const String baseUrl = 'http://10.0.2.2:3001';

  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Users.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar usuário');
    }
  }

  static Future<Users> addUser(Users user) async{
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nome": user.nome,
        "cargo": user.cargo,
        "email": user.email,
        "senha": user.senha,
      }),
    );

    if(response.statusCode ==200){
      return Users.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Erro ao cadatrar usuários');
    }
  }

  static Future<void> deleteUser(String id) async {

    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode != 200){
      throw Exception('Erro ao deletar');
    }
  }

}
