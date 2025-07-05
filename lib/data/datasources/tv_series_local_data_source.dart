import 'package:ditonton/data/models/tv_series_table.dart';

import '../../common/exception.dart';
import 'db/database_helper.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlist(TvSeriesTable tvSeries);
  Future<String> removeWatchlist(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tvSeries);
  Future<List<TvSeriesTable>> getCachedOnTheAirTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tvSeries) async {
    await databaseHelper.clearTvSeriesCache('on the air');
    await databaseHelper.insertTvSeriesCacheTransaction(tvSeries, 'on the air');
  }

  @override
  Future<List<TvSeriesTable>> getCachedOnTheAirTvSeries() async {
    final result = await databaseHelper.getCacheTvSeries('on the air');
    if (result.isNotEmpty) {
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlistTvSeries(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
