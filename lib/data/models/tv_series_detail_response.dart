import 'package:ditonton/domain/entities/tv_series_detail.dart';

import '../../domain/entities/genre.dart';

class TvSeriesDetailResponse {
  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
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
    );
  }
}