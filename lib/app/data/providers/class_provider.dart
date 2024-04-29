import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/utils/auth_storage.dart';

class ClassApiClient {
  final http.Client httpClient = http.Client();
  getAll(String projeto, String periodo) async {
    try {
      final int? teacherId = AuthStorage.getTeacherId();
      var classUrl = Uri.parse(
          '$baseUrl/turmas/professor/$teacherId/projeto/$projeto/periodo/$periodo');
      var response = await httpClient.get(
        classUrl,
        headers: {
          "Accept": "application/json",
          // "Authorization": token,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        Get.defaultDialog(
          title: "Falha",
          content: const Text('Não foi possível carregar as turmas.'),
        );
      }
    } catch (err) {
      throw Exception(err);
    }
    return null;
  }
}
