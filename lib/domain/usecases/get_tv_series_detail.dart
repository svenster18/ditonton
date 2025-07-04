import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/genre.dart';
import '../entities/tv_series_detail.dart';

class GetTvSeriesDetail {
  Future<Either<Failure, TvSeriesDetail>> execute(int id) async {
    return Right(TvSeriesDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'Action')],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 120,
      name: 'name',
      voteAverage: 1,
      voteCount: 1,
    ));
  }
}