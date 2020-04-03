import 'package:meta/meta.dart';
import 'package:novelcovidapiflutterapp/models/novel_covid_model.dart';

import 'novel_covid_api.dart';

class NovelCovidRepository {
  final NovelCovidApi novelCovidApi;

  NovelCovidRepository({@required this.novelCovidApi})
      : assert(novelCovidApi != null);

  Future<NovelCovidModel> fetchNovel(String country) async {
    return await novelCovidApi.getNovel(country);
  }
}
