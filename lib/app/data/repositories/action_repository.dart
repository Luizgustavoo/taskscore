import 'package:taskscore/app/data/models/action_model.dart';
import 'package:taskscore/app/data/providers/action_provider.dart';

class ActionRepository {
  final ActionApiClient apiClient = ActionApiClient();

  getAll() async {
    List<ActionModel> list = <ActionModel>[];

    var response = await apiClient.getAll();

    if (response != null) {
      response['objeto'].forEach((e) {
        list.add(ActionModel.fromJson(e));
      });
    }

    return list;
  }

  sendActionForStudents(List<int> students, List<int> actions) async {
    try {
      var response = await apiClient.sendActionForStudents(students, actions);

      return response;
    } catch (e) {
      print(e);
    }
  }

  removeAction(int id) async {
    try {
      var response = await apiClient.removeAction(id);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
