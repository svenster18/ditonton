import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_status_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieRecommendationsEvent extends Fake
    implements MovieRecommendationsEvent {}

class FakeMovieRecommendationsState extends Fake
    implements MovieRecommendationsState {}

class MockMovieRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class FakeWatchlistEvent extends Fake implements WatchlistEvent {}

class FakeWatchlistState extends Fake implements WatchlistState {}

class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    registerFallbackValue(FakeWatchlistEvent());
    registerFallbackValue(FakeWatchlistState());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<MovieRecommendationsBloc>.value(
            value: mockMovieRecommendationsBloc),
        BlocProvider<WatchlistBloc>.value(value: mockWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsLoaded(testMovieList));
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistStatusLoaded(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsLoaded(testMovieList));
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistStatusLoaded(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsLoaded(testMovieList));
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistStatusLoaded(false));
    whenListen(
        mockWatchlistBloc,
        Stream.fromIterable([
          WatchlistStatusLoaded(false),
          WatchlistSuccess('Added to Watchlist')
        ]));

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailLoaded(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsLoaded(testMovieList));
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistStatusLoaded(false));
    whenListen(
        mockWatchlistBloc,
        Stream.fromIterable(
            [WatchlistStatusLoaded(false), WatchlistSuccess('Failed')]));

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
