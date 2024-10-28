import 'package:get/get.dart';

class FrequencyController extends GetxController {
  var students = [
    {
      'name': 'Adam Diego Bonfati',
      'attendance': ['P', 'F', 'P', 'P', 'P']
    },
    {
      'name': 'Adryan Gabriel Sorecchia',
      'attendance': ['P', 'P', 'P', 'F', 'P']
    },
    {
      'name': 'Alícia Couto de Souza',
      'attendance': ['P', 'P', 'P', 'P', 'P']
    },
    {
      'name': 'Alisson Alves Pelissão',
      'attendance': ['F', 'P', 'P', 'P', 'P']
    },
    {
      'name': 'Amabilly Milena Farias',
      'attendance': ['P', 'F', 'P', 'P', 'P']
    },
    // Adicione mais alunos fictícios
  ].obs;

  // Função para obter frequência de um aluno por índice
  int get numberOfDays =>
      (students.isNotEmpty && students[0]['attendance'] != null)
          ? (students[0]['attendance'] as List).length
          : 0;
}
