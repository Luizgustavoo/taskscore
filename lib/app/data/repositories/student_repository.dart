import 'package:taskscore/app/data/models/student_model.dart';
import 'package:taskscore/app/data/providers/student_provider.dart';

class StudentRepository {
  final StudentApiClient apiClient = StudentApiClient();

  getAll(String dia, String aula, String horario, String oficina) async {
    List<Student> list = <Student>[];

    var response = await apiClient.getAll(dia, aula, horario, oficina);

    if (response != null) {
      response.forEach((e) {
        list.add(Student.fromJson(e));
      });
    }

    return list;
  }
}
