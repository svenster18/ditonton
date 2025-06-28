import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_on_the_air_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _onTheAirTvSeries = <TvSeries>[];

  List<TvSeries> get onTheAirTvSeries => _onTheAirTvSeries;

  RequestState _onTheAirState = RequestState.Empty;

  RequestState get onTheAirState => _onTheAirState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.Empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getOnTheAirTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  final GetOnTheAirTvSeries getOnTheAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchOnTheAirTvSeries() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvSeries.execute();

    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _onTheAirState = RequestState.Loaded;
        _onTheAirTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
  notifyListeners();

  final result = await getPopularTvSeries.execute();
  result.fold((failure) {
    _popularTvSeriesState = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }, (tvSeriesData) {
    _popularTvSeriesState = RequestState.Loaded;
    _popularTvSeries = tvSeriesData;
    notifyListeners();
  });
}

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold((failure) {
      _topRatedTvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _topRatedTvSeriesState = RequestState.Loaded;
      _topRatedTvSeries = tvSeriesData;
      notifyListeners();
    });
  }
}
