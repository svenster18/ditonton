part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

final class OnFetchMovieRecommendations extends MovieRecommendationsEvent {
  final int id;

  OnFetchMovieRecommendations(this.id);
}
