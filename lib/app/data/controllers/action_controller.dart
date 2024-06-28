import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/action_model.dart';
import 'package:taskscore/app/data/models/category_action.dart';
import 'package:taskscore/app/data/repositories/action_repository.dart';

class ActionController extends GetxController {
  RxList<ActionModel> listActions = <ActionModel>[].obs;
  RxList<CategoryAction> listCategoryActions = <CategoryAction>[].obs;

  RxList<bool> itemSelections = RxList<bool>([]);

  RxList<ActionModel> positiveActions = <ActionModel>[].obs;
  RxList<ActionModel> negativeActions = <ActionModel>[].obs;

  TextEditingController acaoController = TextEditingController();
  TextEditingController notaController = TextEditingController();

  RxList<int> selectedIndexes = <int>[].obs;
  RxInt? categorySelected = 0.obs;
  List<int> selectedActions = [];

  final repository = Get.put(ActionRepository());

  @override
  void onInit() {
    getActions();
    super.onInit();
  }

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
      Exception(e);
    }
  }

  Future<void> getCategoryActions() async {
    // isLoading.value = true;
    try {
      listCategoryActions.value = await repository.getAllCategoryAction();
      update();
    } catch (e) {
      Exception(e);
    }
    // isLoading.value = false;
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
      Exception(e);
    }
  }

  Future<void> createAction() async {
    print("Nome da Ação: ${acaoController.text}");
    print("Nota: ${notaController.text}");
    print("Categoria: ${categorySelected!.value}");

    ActionModel actionModel = ActionModel(
      acao: acaoController.text,
      nota: notaController.text,
      categoriaacaoId: categorySelected!.value.toString(),
    );
    try {
      listActions.value = await repository.createAction(actionModel);
      update();
    } catch (e) {
      Exception(e);
    }
  }
}
