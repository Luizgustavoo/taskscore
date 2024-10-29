import 'package:taskscore/app/data/models/frequency_model.dart';
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

  sendObservationForStudents(List<int> students, String observation) async {
    try {
      var response =
          await apiClient.sendObservationForStudents(students, observation);

      return response;
    } catch (e) {
      Exception(e);
    }
  }

  sendFrequencyForStudents(List<int> selectedStudents,
      List<int> nonSelectedStudents, String data) async {
    try {
      var response = await apiClient.sendFrequencyForStudents(
          selectedStudents, nonSelectedStudents, data);

      return response;
    } catch (e) {
      Exception(e);
    }
  }

  existFrequencyForStudents(String data) async {
    try {
      var response = await apiClient.existFrequencyForStudents(data);

      return response;
    } catch (e) {
      Exception(e);
    }
  }

  removeObservation(dynamic id) async {
    try {
      var response = await apiClient.removeObservation(id);
      return response;
    } catch (e) {
      Exception(e);
    }
  }

  viewFrequency(String dia, String aula, String horario, String oficina) async {
    List<Frequency> list = <Frequency>[];

    var response = await apiClient.viewFrequency(dia, aula, horario, oficina);

    if (response != null) {
      response.forEach((e) {
        list.add(Frequency.fromJson(e));
      });
    }

    return list;
  }
}
