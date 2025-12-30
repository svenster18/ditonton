import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

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
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    )..add((OnCall(listenerCallCount)));
  });

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should get data from the usecase',
        build: () {
          _arrangeUsecase();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              MovieDetailLoading(),
              MovieRecommendationsLoading(),
              MovieRecommendationsHasData(tMovies),
              MovieDetailHasData(testMovieDetail),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });

  group('Get Movie Recommendation', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should update error message when request in successful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => <MovieDetailState>[
              MovieDetailLoading(),
              MovieRecommendationsLoading(),
              MovieRecommendationsError('Failed'),
              MovieDetailHasData(testMovieDetail),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchlistStatus(1)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              WatchlistStatusLoaded(true),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(1));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should execute save watchlist when function called',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => <MovieDetailState>[
              WatchlistSuccess('Success'),
              WatchlistStatusLoaded(true),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });
  });
}
