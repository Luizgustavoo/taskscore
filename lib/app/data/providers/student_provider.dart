import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';

class StudentApiClient {
  final http.Client httpClient = http.Client();

  getAll(String dia, String aula, String horario, String oficina) async {
    try {
      var studentUrl = Uri.parse('$baseUrl/alunoshorario/');
      var response = await httpClient.post(studentUrl, headers: {
        "Accept": "application/json",
        // "Authorization": token,
      }, body: {
        "dia": dia,
        "aula": aula,
        "horario": horario,
        "oficina": oficina
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401 &&
          json.decode(response.body)['message'] == "Token has expired") {
        Get.defaultDialog(
          title: "Expirou",
          content: const Text(
              'O token de autenticação expirou, faça login novamente.'),
        );
        // var box = GetStorage('credenciado');
        // box.erase();
        // Get.offAllNamed('/login');
      }
    } catch (err) {
      throw Exception(err);
    }
    return null;
  }
}
