import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/models/frequency_model.dart';
import 'package:taskscore/app/data/models/student_model.dart';
import 'package:taskscore/app/data/repositories/student_repository.dart';

class StudentController extends GetxController {
  late List<String> items;
  late List<bool> itemSelections;

  RxList<int> selectedIndexes = <int>[].obs;
  List<int> allIndexs = [];
  List<int> selectedStudents = [];

  RxList<Student> listStudents = <Student>[].obs;
  RxList<Frequency> listFrequency = <Frequency>[].obs;

  TextEditingController observation = TextEditingController();

  final repository = Get.find<StudentRepository>();
  String? dia;
  String? idHorario;
  String? idOficina;
  String? numeroAula;

  bool isSelection = true;

  void toggleStudentSelection(int index, int idStudent) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
      selectedStudents.remove(idStudent);
    } else {
      selectedIndexes.add(index);
      selectedStudents.add(idStudent);
    }
  }

  sendFrequencyForStudents(String data) async {
    // Obtendo os idsMatricula da lista de alunos
    List<dynamic> idsMatricula =
        listStudents.map((student) => student.idMatricula).toList();

    // Verificando se os idsMatricula são do tipo int
    List<int> idsMatriculaInt = idsMatricula
        .map((id) => id is int ? id : int.tryParse(id.toString()) ?? -1)
        .toList();

    // Verificando se os selectedStudents são do tipo int
    List<int> selectedIds = selectedStudents
        .map((id) => id is int ? id : int.tryParse(id.toString()) ?? -1)
        .toList();

    List<int> studentsNotInSelected = idsMatriculaInt
        .where((student) => !selectedIds.contains(student))
        .toList();

    final response = await repository.sendFrequencyForStudents(
        selectedIds, studentsNotInSelected, data);
    selectedStudents.clear();
    selectedIndexes.clear();

    return response;
  }

  existFrequencyForStudents(String data) async {
    final response = await repository.existFrequencyForStudents(data);
    return response;
  }

  void toggleStudentSelection2(int index, int idStudent) {
    if (isSelection == false) {
      selectedIndexes.clear();

      selectedStudents.clear();
    } else {
      if (!selectedIndexes.contains(index)) {
        selectedIndexes.add(index);
      }
      if (!selectedStudents.contains(idStudent)) {
        selectedStudents.add(idStudent);
      }
    }
  }

  Future<void> getStudents() async {
    try {
      listStudents.value =
          await repository.getAll(dia!, numeroAula!, idHorario!, idOficina!);
      update();
    } catch (e) {
      Exception(e);
    }
  }

  void sort(String type) {
    if (type == "name") {
      listStudents.sort((a, b) =>
          a.nomePessoa!.toString().compareTo(b.nomePessoa!.toString()));
    } else if (type == "score") {
      listStudents.sort(
          (a, b) => double.parse(b.cash).compareTo(double.parse(a.cash!)));
    }

    update();
  }

  sendObservationForStudents() async {
    final list = selectedStudents;

    final response =
        await repository.sendObservationForStudents(list, observation.text);
    selectedStudents.clear();
    selectedIndexes.clear();
    return response;
  }

  removeObservation(dynamic id) async {
    try {
      final response = await repository.removeObservation(id);
      getStudents();
      update();
      return response;
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> viewFrequency(
      String dia, String numeroAula, String idHorario, String idOficina) async {
    try {
      listFrequency.value =
          await repository.viewFrequency(dia, numeroAula, idHorario, idOficina);
      update();
    } catch (e) {
      Exception(e);
    }
  }
}
