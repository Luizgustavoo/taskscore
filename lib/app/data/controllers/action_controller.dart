import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/action_model.dart';
import 'package:taskscore/app/data/repositories/action_repository.dart';

class ActionController extends GetxController {
  RxList<ActionModel> listActions = <ActionModel>[].obs;

  RxList<bool> itemSelections = RxList<bool>([]);

  RxList<ActionModel> positiveActions = <ActionModel>[].obs;
  RxList<ActionModel> negativeActions = <ActionModel>[].obs;

  RxList<int> selectedIndexes = <int>[].obs;
  List<int> selectedActions = [];

  final repository = Get.put(ActionRepository());

  Future<void> getActions() async {
    try {
      listActions.value = await repository.getAll();

      itemSelections.value = List.generate(listActions.length, (_) => false);

      positiveActions.clear();
      negativeActions.clear();

      for (ActionModel action in listActions) {
        if (action.tipoAcao == 'positiva') {
          positiveActions.add(action);
        } else if (action.tipoAcao == 'negativa') {
          negativeActions.add(action);
        }
      }

      update();
    } catch (e) {
      print(e);
    }
  }

  void toggleSelectedActions(int index, int id, dynamic type) {
    if (type == 'remove') {
      selectedIndexes.remove(index);
      selectedActions.remove(id);
    } else {
      selectedIndexes.add(index);
      selectedActions.add(id);
    }
  }

  void clearIndex() {
    selectedIndexes.clear();
    selectedActions.clear();
  }

  sendActionForStudents() async {
    var listActionStudent = {};
    final studentController = Get.put(StudentController());
    final list = studentController.selectedStudents;
    final listAction = selectedActions;

    listActionStudent =
        await repository.sendActionForStudents(list, listAction);
    selectedActions.clear();
    return listActionStudent;
  }

  Future<void> removeAction(int id) async {
    try {
      listActions.value = await repository.removeAction(id);
      update();
    } catch (e) {
      print(e);
    }
  }
}
