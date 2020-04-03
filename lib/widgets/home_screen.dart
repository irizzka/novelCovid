import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelcovidapiflutterapp/blocs/novel_covid_bloc.dart';

import 'country_selection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novel COVID'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final country = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountrySelection(),
                ),
              );
              if (country != null) {
                BlocProvider.of<NovelCovidBloc>(context)
                    .add(FetchNovel(country: country));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<NovelCovidBloc, NovelCovidState>(
          listener: (context, state) {
            print(state.toString() + '   554');
            if (state is NovelCovidLoaded) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is NovelCovidLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NovelCovidLoaded) {
              final novelCovidModel = state.novelCovidModel;
              return Center(
                child: RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<NovelCovidBloc>(context).add(
                      RefreshNovel(country: novelCovidModel.country),
                    );
                    return _refreshCompleter.future;
                  },
                  child: ListView(
                    children: <Widget>[
                      Text("country: " + novelCovidModel.country),
                      Text("cases: " + novelCovidModel.cases.toString()),
                      Text("deaths: " + novelCovidModel.deaths.toString()),
                      Text(
                          "recovered: " + novelCovidModel.recovered.toString()),
                    ],
                  ),
                ),
              );
            }
            if (state is NovelCovidError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Center(child: Text('Please Select a Country'));
          },
        ),
      ),
    );
  }
}
