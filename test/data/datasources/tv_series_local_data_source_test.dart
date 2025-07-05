import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearTvSeriesCache('on the air'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheOnTheAirTvSeries([testTvSeriesCache]);
      // assert
      verify(mockDatabaseHelper.clearTvSeriesCache('on the air'));
      verify(mockDatabaseHelper
          .insertTvSeriesCacheTransaction([testTvSeriesCache], "on the air"));
    });

    test('should return list of tv series from db when data exists', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvSeries('on the air'))
          .thenAnswer((_) async => [testTvSeriesCacheMap]);
      // act
      final result = await dataSource.getCachedOnTheAirTvSeries();
      // assert
      expect(result, [testTvSeriesCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTvSeries('on the air'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedOnTheAirTvSeries();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
