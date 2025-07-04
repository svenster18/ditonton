import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';

class GetTvSeriesRecommendations {
  Future<Either<Failure, List<TvSeries>>> execute(int id) async {
    return Right(<TvSeries>[]);
  }
}