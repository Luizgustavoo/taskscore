import 'package:taskscore/app/data/models/ranking_model.dart';
import 'package:taskscore/app/data/providers/home_provider.dart';

class HomeRepository {
  final HomeApiClient apiClient = HomeApiClient();
  getAll() async {
    List<Ranking> list = <Ranking>[];

    var response = await apiClient.getAll();

    if (response != null) {
      response.forEach((e) {
        list.add(Ranking.fromJson(e));
      });
    }

    return list;
  }
}
