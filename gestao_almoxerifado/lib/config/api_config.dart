import 'dart:io';
import 'package:flutter/foundation.dart'; // 👈 IMPORTANTE

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://10.196.200.12:3001'; // 👈 WEB usa IP também
    } else if (Platform.isAndroid) {
      return 'http://10.196.200.12:3001'; // celular
    } else {
      return 'http://localhost:3001'; // só desktop local
    }
  }
}