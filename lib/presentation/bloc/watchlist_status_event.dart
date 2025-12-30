part of 'watchlist_status_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnAddWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  OnAddWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  OnRemoveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnLoadWatchlistStatus extends WatchlistEvent {
  final int id;

  OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
