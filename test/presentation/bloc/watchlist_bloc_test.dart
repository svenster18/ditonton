import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  final tId = 1;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistBloc = WatchlistBloc(
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  group('Watchlist', () {
    blocTest<WatchlistBloc, WatchlistState>('should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              WatchlistStatusLoaded(true),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        });

    blocTest<WatchlistBloc, WatchlistState>(
        'should execute save watchlist when function called',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => <WatchlistState>[
              WatchlistSuccess('Success'),
              WatchlistStatusLoaded(true),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistBloc, WatchlistState>(
        'should execute remove watchlist when function called',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => <WatchlistState>[
              WatchlistSuccess('Removed'),
              WatchlistStatusLoaded(false),
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistBloc, WatchlistState>(
        'should update watchlist status when add watchlist success',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => <WatchlistState>[
              WatchlistSuccess('Added to Watchlist'),
              WatchlistStatusLoaded(true),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });

    blocTest<WatchlistBloc, WatchlistState>(
        'should update watchlist message when add watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        expect: () => <WatchlistState>[
              WatchlistError('Failed'),
              WatchlistStatusLoaded(true),
            ]);
  });
}
