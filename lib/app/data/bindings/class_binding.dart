import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/class_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/repositories/class_repository.dart';
import 'package:taskscore/app/data/repositories/student_repository.dart';

class ClassBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassController>(() => ClassController());
    Get.lazyPut<ClassRepository>(() => ClassRepository());

    Get.lazyPut<StudentController>(() => StudentController());
    Get.lazyPut<StudentRepository>(() => StudentRepository());
  }
}
