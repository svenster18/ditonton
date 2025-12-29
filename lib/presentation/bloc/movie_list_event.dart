part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class OnFetchNowPlayingMovies extends MovieListEvent {}

class OnFetchPopularMovies extends MovieListEvent {}

class OnFetchTopRatedMovies extends MovieListEvent {}