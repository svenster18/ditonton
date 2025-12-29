part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  // Anda bisa menambahkan state untuk loading dan error per-bagian jika perlu
  // Contoh: final RequestState nowPlayingState;

  const MovieListState({
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
  });

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
    );
  }

  @override
  List<Object> get props => [nowPlayingMovies, popularMovies, topRatedMovies];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListStateError extends MovieListState {
  final String message;

  MovieListStateError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MovieListState {
  final List<Movie> result;

  MovieListHasData(this.result);

  @override
  List<Object> get props => [result];
}