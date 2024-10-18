import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/utils/auth_storage.dart';

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
        "oficina": oficina,
        "teacher_id": AuthStorage.getTeacherId().toString()
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
      }
    } catch (err) {
      throw Exception(err);
    }
    return null;
  }

  sendObservationForStudents(List<int> students, String observation) async {
    final Uri actionUrl = Uri.parse('$baseUrl/lancarobservacoesaluno');
    try {
      final Map<String, dynamic> requestBody = {
        'alunos': students,
        'observacao': observation,
        'usuario_id': AuthStorage.getTeacherId()
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
    } catch (e) {
      Exception(e);
    }
  }

  removeObservation(dynamic id) async {
    var studentUrl = Uri.parse('$baseUrl/removerobservacao');
    try {
      var response = await httpClient.post(studentUrl, body: {
        'id': id.toString(),
      });
      print(response.body);
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
      print(e);
    }
    return null;
  }

  sendFrequencyForStudents(List<int> selectedStudents,
      List<int> nonSelectedStudents, String data) async {
    final Uri actionUrl = Uri.parse('$baseUrl/lancarfrequencia');
    try {
      final Map<String, dynamic> requestBody = {
        'alunos_selecionados': selectedStudents,
        'alunos_nao_selecionados': nonSelectedStudents,
        'data': data,
        'usuario_id': AuthStorage.getTeacherId()
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
    } catch (e) {
      Exception(e);
    }
  }

  existFrequencyForStudents(String data) async {
    final Uri actionUrl = Uri.parse('$baseUrl/existefrequencia');
    try {
      final Map<String, dynamic> requestBody = {
        'data': data,
        'usuario_id': AuthStorage.getTeacherId()
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
    } catch (e) {
      Exception(e);
    }
  }
}
