import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:novelcovidapiflutterapp/blocs/novel_covid_bloc.dart';
import 'package:novelcovidapiflutterapp/repositories/novel_covid_api.dart';
import 'package:novelcovidapiflutterapp/repositories/novel_covid_respositories.dart';
import 'package:novelcovidapiflutterapp/simple_bloc_delegate.dart';
import 'package:novelcovidapiflutterapp/widgets/home_screen.dart';

void main() {
  final NovelCovidRepository novelCovidRepository = NovelCovidRepository(
    novelCovidApi: NovelCovidApi(
      httpClient: http.Client(),
    ),
  );

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp(novelCovidRepository: novelCovidRepository));
}

class MyApp extends StatelessWidget {
  final NovelCovidRepository novelCovidRepository;

  MyApp({Key key, @required this.novelCovidRepository})
      : assert(novelCovidRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      home: BlocProvider(
        create: (context) =>
            NovelCovidBloc(novelCovidRepository: novelCovidRepository),
        child: HomeScreen(),
      ),
    );
  }
}
