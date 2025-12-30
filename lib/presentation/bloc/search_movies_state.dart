part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

final class SearchMoviesEmpty extends SearchMoviesState {}

final class SearchMoviesLoading extends SearchMoviesState {}

final class SearchMoviesError extends SearchMoviesState {
  final String message;

  SearchMoviesError(this.message);
}

final class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> movies;

  SearchMoviesLoaded(this.movies);
}
