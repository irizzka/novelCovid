import 'package:equatable/equatable.dart';

class NovelCovidModel extends Equatable {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final int deathsPerOneMillion;
  final int updated;

  NovelCovidModel(
      {this.country,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.updated});

  static NovelCovidModel fromJson(dynamic json) {
    return NovelCovidModel(
        country: json['country'],
        cases: json['cases'] as int,
        todayCases: json['todayCases'] as int,
        deaths: json['deaths'] as int,
        todayDeaths: json['todayDeaths'] as int,
        recovered: json['recovered'] as int,
        active: json['active'] as int,
        critical: json['critical'] as int,
        casesPerOneMillion: json['casesPerOneMillion'] as int,
      // deathsPerOneMillion: json['deathsPerOneMillion'] as int,
        updated: 0);
  }

  @override
  List<Object> get props => [
        country,
        cases,
        todayCases,
        deaths,
        todayDeaths,
        recovered,
        active,
        critical,
        casesPerOneMillion,
        deathsPerOneMillion,
        updated,
      ];
}
