import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  void _arrangeUsecase() {
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail and Recommendations', () {
    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should get data from the usecase',
        build: () {
          _arrangeUsecase();
          return movieRecommendationsBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendations(tId)),
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should change movie recommendations when data is gotten successfully',
        build: () {
          _arrangeUsecase();
          return movieRecommendationsBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendations(tId)),
        expect: () => [
              MovieRecommendationsLoading(),
              MovieRecommendationsLoaded(tMovies),
            ]);

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should update error message when request in successful',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return movieRecommendationsBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendations(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => <MovieRecommendationsState>[
              MovieRecommendationsLoading(),
              MovieRecommendationsError('Failed'),
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });
}
