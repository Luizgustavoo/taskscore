import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taskscore/app/data/base_url.dart';

class HomeApiClient {
  final http.Client httpClient = http.Client();
  getAll() async {
    try {
      var classUrl = Uri.parse('$baseUrl/rankingmensal');
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
          content: const Text('Não foi possível obter o ranking mensal.'),
        );
      }
    } catch (err) {
      throw Exception(err);
    }
    return null;
  }
}
