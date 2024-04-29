import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/repositories/student_repository.dart';

class StudentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentController>(() => StudentController());
    Get.lazyPut<StudentRepository>(() => StudentRepository());
  }
}
