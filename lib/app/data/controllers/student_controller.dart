import 'package:get/get.dart';
import 'package:taskscore/app/data/models/student_model.dart';
import 'package:taskscore/app/data/repositories/student_repository.dart';

class StudentController extends GetxController {
  late List<String> items;
  late List<bool> itemSelections;

  RxList<int> selectedIndexes = <int>[].obs;
  List<int> allIndexs = [];
  List<int> selectedStudents = [];

  RxList<Student> listStudents = <Student>[].obs;

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
}
