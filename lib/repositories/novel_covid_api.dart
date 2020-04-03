import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:novelcovidapiflutterapp/models/novel_covid_model.dart';

class NovelCovidApi {
  static const baseUrl = 'https://corona.lmao.ninja';
  final http.Client httpClient;

  NovelCovidApi({@required this.httpClient}) : assert(httpClient != null);

  Future<NovelCovidModel> getNovel(String country) async {
    final novelCovidUrl = '$baseUrl/countries/$country';
    final novelCovidResponse = await httpClient.get(novelCovidUrl

        );

    if (novelCovidResponse.statusCode != 200) {
      throw Exception('error getting status for location');
    }

    final novelCovidJson = jsonDecode(novelCovidResponse.body);
    return NovelCovidModel.fromJson(novelCovidJson);
  }
}
