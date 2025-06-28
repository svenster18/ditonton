import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_on_the_air_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _onTheAirTvSeries = <TvSeries>[];

  List<TvSeries> get onTheAirTvSeries => _onTheAirTvSeries;

  //
  RequestState _onTheAirState = RequestState.Empty;

  RequestState get onTheAirState => _onTheAirState;

  // var _popularMovies = <Movie>[];
  // List<Movie> get popularMovies => _popularMovies;
  //
  // RequestState _popularMoviesState = RequestState.Empty;
  // RequestState get popularMoviesState => _popularMoviesState;
  //
  // var _topRatedMovies = <Movie>[];
  // List<Movie> get topRatedMovies => _topRatedMovies;
  //
  // RequestState _topRatedMoviesState = RequestState.Empty;
  // RequestState get topRatedMoviesState => _topRatedMoviesState;
  //
  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getOnTheAirTvSeries,
    // required this.getPopularMovies,
    // required this.getTopRatedMovies,
  });

  final GetOnTheAirTvSeries getOnTheAirTvSeries;

  // final GetPopularMovies getPopularMovies;
  // final GetTopRatedMovies getTopRatedMovies;

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

// Future<void> fetchPopularMovies() async {
//   _popularMoviesState = RequestState.Loading;
//   notifyListeners();
//
//   final result = await getPopularMovies.execute();
//   result.fold(
//         (failure) {
//       _popularMoviesState = RequestState.Error;
//       _message = failure.message;
//       notifyListeners();
//     },
//         (moviesData) {
//       _popularMoviesState = RequestState.Loaded;
//       _popularMovies = moviesData;
//       notifyListeners();
//     },
//   );
// }
//
// Future<void> fetchTopRatedMovies() async {
//   _topRatedMoviesState = RequestState.Loading;
//   notifyListeners();
//
//   final result = await getTopRatedMovies.execute();
//   result.fold(
//         (failure) {
//       _topRatedMoviesState = RequestState.Error;
//       _message = failure.message;
//       notifyListeners();
//     },
//         (moviesData) {
//       _topRatedMoviesState = RequestState.Loaded;
//       _topRatedMovies = moviesData;
//       notifyListeners();
//     },
//   );
// }
}
