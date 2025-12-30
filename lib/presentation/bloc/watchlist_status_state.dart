part of 'watchlist_status_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

final class WatchlistStatusEmpty extends WatchlistState {}

final class WatchlistStatusLoaded extends WatchlistState {
  final bool isAddedToWatchlist;

  WatchlistStatusLoaded(this.isAddedToWatchlist);
}

final class WatchlistSuccess extends WatchlistState {
  final String message;

  WatchlistSuccess(this.message);
}

final class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);
}
