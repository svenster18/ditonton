import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';
import 'tv_series_list_notifier_test.mocks.dart';

// @GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
@GenerateMocks([GetOnTheAirTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;
  // late MockGetPopularMovies mockGetPopularMovies;
  // late MockGetTopRatedMovies mockGetTopRatedMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    //   mockGetPopularMovies = MockGetPopularMovies();
    //   mockGetTopRatedMovies = MockGetTopRatedMovies();
    provider = TvSeriesListNotifier(
      getOnTheAirTvSeries: mockGetOnTheAirTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
    //   provider = MovieListNotifier(
    //     getNowPlayingMovies: mockGetNowPlayingMovies,
    //     getPopularMovies: mockGetPopularMovies,
    //     getTopRatedMovies: mockGetTopRatedMovies,
    //   )..addListener(() {
    //     listenerCallCount += 1;
    //   });
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('on the air tv series', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchOnTheAirTvSeries();
      // assert
      verify(mockGetOnTheAirTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchOnTheAirTvSeries();
      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchOnTheAirTvSeries();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });
    //
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTvSeries();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    // test('should change state to loading when usecase is called', () async {
    //   // arrange
    //   when(mockGetPopularMovies.execute())
    //       .thenAnswer((_) async => Right(tMovieList));
    //   // act
    //   provider.fetchPopularMovies();
    //   // assert
    //   expect(provider.popularMoviesState, RequestState.Loading);
    //   // verify(provider.setState(RequestState.Loading));
    // });
    //
    // test('should change movies data when data is gotten successfully',
    //         () async {
    //       // arrange
    //       when(mockGetPopularMovies.execute())
    //           .thenAnswer((_) async => Right(tMovieList));
    //       // act
    //       await provider.fetchPopularMovies();
    //       // assert
    //       expect(provider.popularMoviesState, RequestState.Loaded);
    //       expect(provider.popularMovies, tMovieList);
    //       expect(listenerCallCount, 2);
    //     });
    //
    // test('should return error when data is unsuccessful', () async {
    //   // arrange
    //   when(mockGetPopularMovies.execute())
    //       .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    //   // act
    //   await provider.fetchPopularMovies();
    //   // assert
    //   expect(provider.popularMoviesState, RequestState.Error);
    //   expect(provider.message, 'Server Failure');
    //   expect(listenerCallCount, 2);
    // });
  });

  group('top rated movies', () {
    // test('should change state to loading when usecase is called', () async {
    //   // arrange
    //   when(mockGetTopRatedMovies.execute())
    //       .thenAnswer((_) async => Right(tMovieList));
    //   // act
    //   provider.fetchTopRatedMovies();
    //   // assert
    //   expect(provider.topRatedMoviesState, RequestState.Loading);
    // });
    //
    // test('should change movies data when data is gotten successfully',
    //         () async {
    //       // arrange
    //       when(mockGetTopRatedMovies.execute())
    //           .thenAnswer((_) async => Right(tMovieList));
    //       // act
    //       await provider.fetchTopRatedMovies();
    //       // assert
    //       expect(provider.topRatedMoviesState, RequestState.Loaded);
    //       expect(provider.topRatedMovies, tMovieList);
    //       expect(listenerCallCount, 2);
    //     });
    //
    // test('should return error when data is unsuccessful', () async {
    //   // arrange
    //   when(mockGetTopRatedMovies.execute())
    //       .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    //   // act
    //   await provider.fetchTopRatedMovies();
    //   // assert
    //   expect(provider.topRatedMoviesState, RequestState.Error);
    //   expect(provider.message, 'Server Failure');
    //   expect(listenerCallCount, 2);
    // });
  });
}
