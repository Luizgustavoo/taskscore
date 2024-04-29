import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';

class LoginApiClient {
  final http.Client httpClient = http.Client();

  Future<Map<String, dynamic>?> login(String usuario, String senha) async {
    var loginUrl = Uri.parse('$baseUrl/loginAppAcao');
    try {
      var response = await httpClient
          .post(loginUrl, body: {'usuario': usuario, 'senha': senha});

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Erro de Autenticação',
          'Usuário ou senha inválidos',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
