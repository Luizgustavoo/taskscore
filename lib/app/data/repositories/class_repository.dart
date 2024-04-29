import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:taskscore/app/data/providers/class_provider.dart';

class ClassRepository {
  final ClassApiClient apiClient = ClassApiClient();
  Future<RxMap<String, List<Map<String, String>>>> getAll(
      String projeto, String periodo) async {
    var response = await apiClient.getAll(projeto, periodo);
    RxMap<String, List<Map<String, String>>> aulasPorDia =
        <String, List<Map<String, String>>>{}.obs;

    // Agrupando os dados por dia
    if (response != null) {
      response.forEach((aula) {
        String dia = aula['idDia'];
        aulasPorDia.putIfAbsent(dia, () => <Map<String, String>>[].obs);
        aulasPorDia[dia]!.add({
          'numeroAula': aula['numeroAula'],
          'alias': aula['alias'],
          'idOficina': aula['idOficina'],
          'idHorario': aula['idHorario']
        });
      });
    }
    return aulasPorDia;
  }
}
