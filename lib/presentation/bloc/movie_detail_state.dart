part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailEmpty extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailLoaded(this.movie);
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}

final class WatchlistSuccess extends MovieDetailState {
  final String message;

  WatchlistSuccess(this.message);
}

final class WatchlistError extends MovieDetailState {
  final String message;

  WatchlistError(this.message);
}

final class WatchlistStatusLoaded extends MovieDetailState {
  final bool isAddedToWatchlist;

  WatchlistStatusLoaded(this.isAddedToWatchlist);
}

final class CallCountAdded extends MovieDetailState {
  final int callCount;

  CallCountAdded(this.callCount);
}
