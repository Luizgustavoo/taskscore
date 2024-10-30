import 'package:get/get.dart';
import 'package:taskscore/app/data/models/frequency_model.dart';

class FrequencyController extends GetxController {
  RxList<Frequency> listFrequency = <Frequency>[].obs;

  String? dia;
  String? idHorario;
  String? idOficina;
  String? numeroAula;

  List<Student> students = [
    Student(
      name: 'Adam Diego Bonfati',
      dia01: 'P',
      dia02: 'F',
      dia03: 'F',
      dia04: 'P',
      dia05: 'P',
    ),

    Student(
      name: 'Adam Diego Bonfati',
      dia01: 'P',
      dia02: 'F',
      dia03: 'F',
      dia04: 'P',
      dia05: 'P',
    ),

    Student(
      name: 'Luiz viadao',
      dia01: 'F',
      dia02: 'F',
      dia03: 'F',
      dia04: 'P',
      dia05: 'P',
    ),

    // Adicione mais alunos fictícios
  ].obs;

  // Função para obter frequência de um aluno por índice
  int get numberOfDays => (students.isNotEmpty) ? 5 : 0;
}

class Student {
  String? name;
  dynamic dia01;
  dynamic dia02;
  dynamic dia03;
  dynamic dia04;
  dynamic dia05;
  Student({
    this.name,
    this.dia01,
    this.dia02,
    this.dia03,
    this.dia04,
    this.dia05,
  });
}
