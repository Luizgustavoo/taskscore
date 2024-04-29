import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/login_controller.dart';
import 'package:taskscore/app/data/repositories/login_repository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<LoginRepository>(() => LoginRepository());
  }
}
