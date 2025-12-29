import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';

import '../../domain/usecases/get_now_playing_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListBloc(this._getNowPlayingMovies) : super(MovieListEmpty()) {
   on<OnFetchNowPlayingMovies>((event, emit) async {
     emit(MovieListLoading());
     final result = await _getNowPlayingMovies.execute();
     result.fold(
       (failure) {
         emit(MovieListStateError(failure.message));
       },
       (result) {
         emit(MovieListHasData(result));
       },
     );
   });
  }
}