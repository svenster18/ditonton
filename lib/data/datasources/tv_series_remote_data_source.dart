import '../models/tv_series_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    return <TvSeriesModel>[];
  }
}