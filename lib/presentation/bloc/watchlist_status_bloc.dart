import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'watchlist_status_event.dart';
part 'watchlist_status_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistStatusEmpty()) {
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
