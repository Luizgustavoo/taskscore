import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';

class ActionApiClient {
  final http.Client httpClient = http.Client();
  getAll() async {
    try {
      var actionUrl = Uri.parse('$baseUrl/listaracao/');
      var response = await httpClient.get(actionUrl, headers: {
        "Accept": "application/json",
        // "Authorization": token,
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        Get.defaultDialog(
          title: "Falha",
          content: const Text('Falha ao tentar obter as ações.'),
        );
      }
    } catch (err) {
      throw Exception(err);
    }
    return null;
  }

  sendActionForStudents(List<int> students, List<int> actions) async {
    final Uri sendActionUrl = Uri.parse('$baseUrl/sendactionforstudents');
    try {
      final Map<String, dynamic> requestBody = {
        'users': students,
        'actions': actions,
      };

      final http.Response response = await http.post(
        sendActionUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        print('Erro 401 - Não autorizado');
        // Lidar com erro 401 aqui, se necessário
      }
    } catch (error) {
      print('Erro ao enviar dados: $error');
    }
  }
}
