import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

import '../../common/failure.dart';
import '../repositories/tv_series_repository.dart';

class GetPopularTvSeries {
  final TvSeriesRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() async {
    return repository.getPopularTvSeries();
  }
}
