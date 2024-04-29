import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskscore/app/data/models/login_model.dart';
import 'package:taskscore/app/data/repositories/login_repository.dart';

class LoginController extends GetxController {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  final formKey = GlobalKey<FormState>();
  RxBool showErrorSnackbar = false.obs;
  final box = GetStorage('taskscore');

  LoginModel? auth;
  RxBool isLoggingIn = false.obs;
  RxBool loading = false.obs;
  final repository = Get.find<LoginRepository>();

  void login() async {
    if (formKey.currentState!.validate()) {
      isLoggingIn.value = true;
      loading.value = true;

      auth =
          await repository.login(controllerUsuario.text, controllerSenha.text);
      if (auth != null) {
        box.write('auth', auth?.toJson());
        Get.offAllNamed('/');
      }
    } else {
      showErrorSnackbar.value = true;
      showErrorMessage();
    }

    loading.value = false;
    isLoggingIn.value = false;
  }

  String? validatePassword(String? value, bool isLogin) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite sua senha';
    }

    if (!isLogin) {
      if (value != controllerSenha.text) {
        return 'A senhas não coincidem';
      }
    }

    if (value.length < 4) {
      return 'A senha deve conter 4 caracteres';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite seu usuário';
    }

    return null;
  }

  void showErrorMessage() {
    if (showErrorSnackbar.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Erro de Autenticação',
          'Usuário ou senha inválidos',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        showErrorSnackbar.value = false;
      });
    }
  }
}
