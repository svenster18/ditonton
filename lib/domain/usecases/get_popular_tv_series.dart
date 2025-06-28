import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

import '../../common/failure.dart';

class GetPopularTvSeries {

  GetPopularTvSeries();

  Future<Either<Failure, List<TvSeries>>> execute() async {
    return Right([]);
  }
}