import 'package:get/get.dart';
import 'package:taskscore/app/data/models/login_model.dart';
import 'package:taskscore/app/utils/auth_storage.dart';

class SplashController extends GetxController {
  void checkUserLoginStatus() {
    LoginModel? authData = AuthStorage.getAuthData();

    if (authData != null) {
      Get.offAllNamed('/');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
