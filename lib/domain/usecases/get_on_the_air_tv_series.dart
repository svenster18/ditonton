import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetOnTheAirTvSeries {
  // final MovieRepository repository;

  // GetOnTheAirTvSeries(this.repository);
  GetOnTheAirTvSeries();

  // Future<Either<Failure, List<Movie>>> execute() {
  //   // return repository.getOnTheAirTvSeries();
  // }

  Future<Either<Failure, List<TvSeries>>> execute() async {
    return Right(<TvSeries>[]);
  }
}
