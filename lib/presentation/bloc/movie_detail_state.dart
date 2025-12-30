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
