import 'package:ditonton/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tvSeries);
  Future<List<TvSeriesTable>> getCachedOnTheAirTvSeries();
}