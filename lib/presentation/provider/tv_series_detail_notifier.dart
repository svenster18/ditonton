import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_recommendations.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_tv_series_watchlist.dart';
import '../../domain/usecases/save_tv_series_watchlist.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetTvSeriesWatchlistStatus getWatchListStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
  });

  late TvSeriesDetail _tvSeries;

  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;

  RequestState get tvSeriesState => _tvSeriesState;

  List<TvSeries> _tvSeriesRecommendations = [];

  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold((failure) {
      _tvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeries) {
      _recommendationState = RequestState.Loading;
      _tvSeries = tvSeries;
      notifyListeners();
      recommendationResult.fold((failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
      }, (tvSeriesList) {
        _recommendationState = RequestState.Loaded;
        _tvSeriesRecommendations = tvSeriesList;
      });
      _tvSeriesState = RequestState.Loaded;
      notifyListeners();
    });
  }

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveTvSeriesWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeTvSeriesWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );
    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
