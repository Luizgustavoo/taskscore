import 'package:taskscore/app/data/models/login_model.dart';
import 'package:taskscore/app/data/providers/login_provider.dart';

class LoginRepository {
  final LoginApiClient apiClient = LoginApiClient();
  Future<LoginModel?> login(String username, String password) async {
    var json = await apiClient.login(username, password);
    if (json!['objeto'] != null && json['objeto'].isNotEmpty) {
      return LoginModel.fromJson(json['objeto']);
    } else {
      return null;
    }
  }
}
