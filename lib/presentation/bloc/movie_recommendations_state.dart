part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationsEmpty extends MovieRecommendationsState {}

final class MovieRecommendationsLoading extends MovieRecommendationsState {}

final class MovieRecommendationsLoaded extends MovieRecommendationsState {
  final List<Movie> recommendations;

  MovieRecommendationsLoaded(this.recommendations);
}

final class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationsError(this.message);
}
