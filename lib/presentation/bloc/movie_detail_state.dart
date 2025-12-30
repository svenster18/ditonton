part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailEmpty extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailHasData(this.movie);
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}

final class MovieRecommendationsLoading extends MovieDetailState {}

final class MovieRecommendationsHasData extends MovieDetailState {
  final List<Movie> recommendations;

  MovieRecommendationsHasData(this.recommendations);
}

final class MovieRecommendationsError extends MovieDetailState {
  final String message;

  MovieRecommendationsError(this.message);
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
