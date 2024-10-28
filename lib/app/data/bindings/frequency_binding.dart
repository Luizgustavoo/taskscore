import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/frequency_controller.dart';

class FrequencyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrequencyController>(() => FrequencyController());
  }
}
