import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';

class GetTopRatedTvSeries {
  Future<Either<Failure, List<TvSeries>>> execute() async {
    return Right(<TvSeries>[]);
  }
}
