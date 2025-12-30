import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailBloc(this._getMovieDetail, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MovieDetailEmpty()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final id = event.id;
      final detailResult = await _getMovieDetail.execute(id);
      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieDetailLoaded(movie));
        },
      );
    });

    on<OnAddWatchlist>((event, emit) async {
      final result = await _saveWatchlist.execute(event.movie);

      result.fold((failure) async {
        emit(WatchlistError(failure.message));
      }, (successMessage) async {
        emit(WatchlistSuccess(successMessage));
      });
      add(OnLoadWatchlistStatus(event.movie.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await _removeWatchlist.execute(event.movie);

      result.fold((failure) async {
        emit(WatchlistError(failure.message));
      }, (successMessage) async {
        emit(WatchlistSuccess(successMessage));
      });
      add(OnLoadWatchlistStatus(event.movie.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await _getWatchListStatus.execute(event.id);
      emit(WatchlistStatusLoaded(result));
    });
  }
}
