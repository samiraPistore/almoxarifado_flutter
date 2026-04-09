import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';

class DashboardService {
  static const String baseUrl = 'http://10.0.2.2:3001';

  static Future<DashboardModel> fetchIndic() async{
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
    );
    
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return DashboardModel.fromJson(data);
    }else{
    throw Exception('Erro ao buscar indicadores');
    }
  }
}