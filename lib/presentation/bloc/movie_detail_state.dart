part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailEmpty extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieRecommendationsLoading extends MovieDetailState {}

final class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailHasData(this.movie);
}

final class MovieRecommendationsHasData extends MovieDetailState {
  final List<Movie> recommendations;

  MovieRecommendationsHasData(this.recommendations);
}

final class MovieDetailWatchlistAdded extends MovieDetailState {
  final String message;

  MovieDetailWatchlistAdded(this.message);
}

final class MovieDetailWatchlistRemoved extends MovieDetailState {
  final String message;

  MovieDetailWatchlistRemoved(this.message);
}

final class MovieDetailHasWatchlistStatus extends MovieDetailState {
  final bool isAddedToWatchlist;

  MovieDetailHasWatchlistStatus(this.isAddedToWatchlist);
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}

final class MovieRecommendationsError extends MovieDetailState {
  final String message;

  MovieRecommendationsError(this.message);
}
