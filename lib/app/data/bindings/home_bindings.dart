import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/class_controller.dart';
import 'package:taskscore/app/data/controllers/home_controller.dart';
import 'package:taskscore/app/data/repositories/class_repository.dart';
import 'package:taskscore/app/data/repositories/home_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeRepository>(() => HomeRepository());
    Get.lazyPut<ClassController>(() => ClassController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());
  }
}
