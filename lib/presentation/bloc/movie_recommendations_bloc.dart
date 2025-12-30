import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<OnFetchMovieRecommendations>((event, emit) async {
      emit(MovieRecommendationsLoading());
      final id = event.id;
      final recommendationResult = await _getMovieRecommendations.execute(id);
      recommendationResult.fold((failure) {
        emit(MovieRecommendationsError(failure.message));
      }, (movies) {
        emit(MovieRecommendationsLoaded(movies));
      });
    });
  }
}
