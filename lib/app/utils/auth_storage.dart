import 'package:get_storage/get_storage.dart';
import 'package:taskscore/app/data/models/login_model.dart';

class AuthStorage {
  static final GetStorage _storage = GetStorage('taskscore');

  static const String authKey = 'auth';

  static void saveAuthData(LoginModel? auth) {
    if (auth != null) {
      _storage.write(authKey, auth.toJson());
    } else {
      _storage.remove(authKey);
    }
  }

  static LoginModel? getAuthData() {
    final data = _storage.read(authKey);
    if (data != null) {
      return LoginModel.fromJson(data);
    }
    return null;
  }

  static void removeAuthData() {
    _storage.remove(authKey);
  }

  static int? getTeacherId() {
    LoginModel? authData = getAuthData();

    if (authData != null) {
      return int.tryParse(authData.idProfessor!);
    }

    return null;
  }

  static String? getUserName() {
    LoginModel? authData = getAuthData();

    if (authData != null) {
      return authData.nomeUsuario!;
    }

    return null;
  }

  static String? getUserPhoto() {
    LoginModel? authData = getAuthData();

    if (authData != null) {
      return authData.avatar.toString();
    }

    return null;
  }
}
