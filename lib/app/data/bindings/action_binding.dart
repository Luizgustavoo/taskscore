import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/action_controller.dart';

class ActionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActionController>(() => ActionController());
  }
}
