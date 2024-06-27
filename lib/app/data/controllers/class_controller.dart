import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/models/class_model.dart';
import 'package:taskscore/app/data/repositories/class_repository.dart';

class ClassController extends GetxController {
  List<String> items = List.generate(20, (index) => 'Turmaª ${index + 1}');
  late List<String> filteredItems = List.from(items);
  RxList<Class> listClasses = <Class>[].obs;
  final repository = Get.find<ClassRepository>();

  RxBool matCrescer1 = false.obs;
  RxBool vespCrescer1 = false.obs;
  RxBool matCrescer2 = false.obs;
  RxBool vespCrescer2 = false.obs;

  RxMap<String, List<Map<String, String>>> aulasPorDia =
      <String, List<Map<String, String>>>{}.obs;

  Color randomColor() {
    List<Color> colors = [
      Colors.red,
      Colors.red.shade600,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple.shade300,
      Colors.amber,
      Colors.blueGrey,
      Colors.cyan,
      Colors.brown.shade300,
      Colors.tealAccent,
      Colors.pinkAccent.shade100,
      Colors.deepOrange,
      Colors.lightBlue,
    ];

    return colors[Random().nextInt(colors.length)];
  }

  Future<void> getClasses(String projeto, String periodo) async {
    try {
      aulasPorDia.value = await repository.getAll(projeto, periodo);
      update();
    } catch (e) {
      Exception(e);
    }
  }
}
