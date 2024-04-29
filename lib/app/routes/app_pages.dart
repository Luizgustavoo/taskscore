import 'package:get/get.dart';
import 'package:taskscore/app/data/bindings/class_binding.dart';
import 'package:taskscore/app/data/bindings/home_bindings.dart';
import 'package:taskscore/app/data/bindings/login_binding.dart';
import 'package:taskscore/app/data/bindings/splash_binding.dart';
import 'package:taskscore/app/data/bindings/student_binding.dart';
import 'package:taskscore/app/modules/class/class_view.dart';
import 'package:taskscore/app/modules/home/home_view.dart';
import 'package:taskscore/app/modules/login/login_view.dart';
import 'package:taskscore/app/modules/splash/splash_view.dart';
import 'package:taskscore/app/modules/student/student_view.dart';
import 'package:taskscore/app/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.CLASS,
      page: () => ClassView(),
      binding: ClassBinding(),
    ),
    GetPage(
      name: Routes.STUDENT,
      page: () => const StudentView(),
      binding: StudentBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}
