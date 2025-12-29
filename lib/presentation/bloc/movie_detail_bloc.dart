import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailBloc(this._getMovieDetail, this._getMovieRecommendations,
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(MovieDetailEmpty()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final id = event.id;
      final detailResult = await _getMovieDetail.execute(id);
      final recommendationResult = await _getMovieRecommendations.execute(id);
      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieRecommendationsLoading());
          recommendationResult.fold(
            (failure) {
              emit(MovieRecommendationsError(failure.message));
            },
            (movies) {
              emit(MovieRecommendationsHasData(movies));
            },
          );
          emit(MovieDetailHasData(movie));
        },
      );
    });
  }
}
