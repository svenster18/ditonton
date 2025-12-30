part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;

  OnFetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  OnAddWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  OnRemoveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnLoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnCall extends MovieDetailEvent {
  final int callCount;

  const OnCall(this.callCount);

  @override
  List<Object> get props => [callCount];
}
