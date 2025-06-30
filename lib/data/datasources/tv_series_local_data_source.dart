import 'package:ditonton/data/models/tv_series_table.dart';

import '../../common/exception.dart';
import 'db/database_helper.dart';

abstract class TvSeriesLocalDataSource {
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tvSeries);
  Future<List<TvSeriesTable>> getCachedOnTheAirTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tvSeries) async {
    await databaseHelper.clearCache('on the air');
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
}
