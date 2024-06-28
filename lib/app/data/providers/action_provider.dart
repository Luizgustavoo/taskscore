import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/models/action_model.dart';
import 'package:taskscore/app/utils/auth_storage.dart';

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

  getAllCategoryAction() async {
    try {
      var actionUrl = Uri.parse('$baseUrl/listarcategoriaacao');
      var response = await httpClient.get(actionUrl);
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
    final Uri actionUrl = Uri.parse('$baseUrl/sendactionforstudents');
    try {
      final Map<String, dynamic> requestBody = {
        'users': students,
        'actions': actions,
        'teacher_id': AuthStorage.getTeacherId()
      };

      final http.Response response = await http.post(
        actionUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (error) {
      print('Erro ao enviar dados: $error');
    }
  }

  removeAction(int id) async {
    var actionUrl = Uri.parse('$baseUrl/removeracaoaluno');
    try {
      var response =
          await httpClient.post(actionUrl, body: {'id': id.toString()});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Falha',
          'Ação não removida',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Exception(e);
    }
    return null;
  }

  createAction(ActionModel actionModel) async {
    var actionUrl = Uri.parse('$baseUrl/criaracao');
    try {
      var response = await httpClient.post(actionUrl, body: {
        "acao": actionModel.acao,
        "nota": actionModel.nota.toString(),
        "categoria_id": actionModel.categoriaacaoId.toString()
      });
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Falha',
          'Erro ao cadastrar',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Exception(e);
    }
    return null;
  }
}
