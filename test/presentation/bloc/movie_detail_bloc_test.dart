import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  final tId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
    );
  });

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
  }

  group('Get Movie Detail and Recommendations', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should get data from the usecase',
        build: () {
          _arrangeUsecase();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should change movie when data is gotten successfully',
        build: () {
          _arrangeUsecase();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailLoaded(testMovieDetail),
            ]);

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should update error message when request in successful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => <MovieDetailState>[
              MovieDetailLoading(),
              MovieDetailLoaded(testMovieDetail),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });

  group('on Error', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failed')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => <MovieDetailState>[
              MovieDetailLoading(),
              MovieDetailError('Server Failure'),
            ]);
  });
}
