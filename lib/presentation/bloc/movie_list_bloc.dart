import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieListBloc(this._getNowPlayingMovies, this._getPopularMovies, this._getTopRatedMovies) : super(MovieListEmpty()) {
   on<OnFetchNowPlayingMovies>((event, emit) async {
     emit(MovieListLoading());
     final result = await _getNowPlayingMovies.execute();
     result.fold(
       (failure) {
          emit(MovieListError(failure.message));
        },
           (movies) {
         emit(state.copyWith(nowPlayingMovies: movies));
       },
     );
   });
   on<OnFetchPopularMovies>((event, emit) async {
     emit(MovieListLoading());
     final result = await _getPopularMovies.execute();
     result.fold(
       (failure) {
          emit(MovieListError(failure.message));
        },
       (movies) {
         emit(state.copyWith(popularMovies: movies));
       },
     );
   });
   on<OnFetchTopRatedMovies>((event, emit) async {
     emit(MovieListLoading());
     final result = await _getTopRatedMovies.execute();
     result.fold(
       (failure) {
          emit(MovieListError(failure.message));
        },
           (movies) {
         emit(state.copyWith(topRatedMovies: movies));
       },
     );
   });
  }
}