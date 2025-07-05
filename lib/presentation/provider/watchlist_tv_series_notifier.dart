import 'dart:async';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/usecases/get_watchlist_tv_series.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesNotifier({required this.getWatchlistTvSeries});

  RequestState _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  List<TvSeries> _watchlistTvSeries = [];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();
    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeries = data;
        notifyListeners();
      },
    );
  }
  
}