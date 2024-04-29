import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/models/ranking_model.dart';
import 'package:taskscore/app/data/repositories/home_repository.dart';
import 'package:taskscore/app/utils/auth_storage.dart';

class HomeController extends GetxController {
  final repository = Get.find<HomeRepository>();

  RxList<Ranking> listRankings = <Ranking>[].obs;

  @override
  void onInit() {
    getRankigs();
    super.onInit();
  }

  void signOut() {
    AuthStorage.removeAuthData();
    Get.offAllNamed('login');
  }

  Color randomColor() {
    List<Color> colors = [
      Colors.red.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.yellow,
      Colors.orange.shade100,
      Colors.purple.shade200,
      Colors.amber.shade100,
      Colors.blueGrey.shade100,
      Colors.cyan.shade100,
      Colors.brown.shade200,
      Colors.tealAccent.shade100,
      Colors.pinkAccent.shade100,
      Colors.deepOrange.shade100,
      Colors.lightBlue.shade100,
    ];

    return colors[Random().nextInt(colors.length)];
  }

  String actualMonth() {
    DateTime now = DateTime.now();
    int month = now.month;

    List<String> monthsInPortuguese = [
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro"
    ];
    return monthsInPortuguese[month - 1];
  }

  Future<void> getRankigs() async {
    try {
      listRankings.value = await repository.getAll();
      update();
    } catch (e) {
      print(e);
    }
  }
}
