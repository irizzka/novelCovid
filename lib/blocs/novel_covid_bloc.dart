import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:novelcovidapiflutterapp/models/novel_covid_model.dart';
import 'package:novelcovidapiflutterapp/repositories/novel_covid_respositories.dart';

abstract class NovelCovidEvent extends Equatable {
  const NovelCovidEvent();
  @override
  List<Object> get props => [];
}

class FetchNovel extends NovelCovidEvent {
  final String country;

  const FetchNovel({@required this.country}) : assert(country != null);

  @override
  List<Object> get props => [country];
}

class RefreshNovel extends NovelCovidEvent {
  final String country;

  const RefreshNovel({@required this.country}) : assert(country != null);

  @override
  List<Object> get props => [country];
}

abstract class NovelCovidState extends Equatable {
  const NovelCovidState();

  @override
  List<Object> get props => [];
}

class NovelCovidEmpty extends NovelCovidState {}

class NovelCovidLoading extends NovelCovidState {}

class NovelCovidLoaded extends NovelCovidState {
  final NovelCovidModel novelCovidModel;

  const NovelCovidLoaded({@required this.novelCovidModel})
      : assert(novelCovidModel != null);

  @override
  List<Object> get props => [novelCovidModel];
}

class NovelCovidError extends NovelCovidState {}

class NovelCovidBloc extends Bloc<NovelCovidEvent, NovelCovidState> {
  final NovelCovidRepository novelCovidRepository;

  NovelCovidBloc({@required this.novelCovidRepository})
      : assert(novelCovidRepository != null);

  @override
  NovelCovidState get initialState => NovelCovidEmpty();

  @override
  Stream<NovelCovidState> mapEventToState(NovelCovidEvent event) async* {
    if (event is FetchNovel) {
      yield* _mapFetchNovelToState(event);
    } else if (event is RefreshNovel) {
      yield* _mapRefreshNovelToState(event);
    }
  }

  Stream<NovelCovidState> _mapFetchNovelToState(FetchNovel event) async* {
    yield NovelCovidLoading();
    try {
      final NovelCovidModel novelCovidModel =
          await novelCovidRepository.fetchNovel(event.country);
      yield NovelCovidLoaded(novelCovidModel: novelCovidModel);
    } catch (_) {
      yield NovelCovidError();
    }
  }

  Stream<NovelCovidState> _mapRefreshNovelToState(RefreshNovel event) async* {
    try {
      final NovelCovidModel novelCovidModel =
          await novelCovidRepository.fetchNovel(event.country);
      yield NovelCovidLoaded(novelCovidModel: novelCovidModel);
    } catch (_) {
      yield state;
    }
  }
}
