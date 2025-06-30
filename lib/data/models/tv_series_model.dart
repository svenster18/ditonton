import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_series_model.g.dart';

@JsonSerializable()
class TvSeriesModel extends Equatable {
  TvSeriesModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "genre_ids")
  List<int>? genreIds;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "origin_country")
  List<String>? originCountry;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_name")
  String? originalName;
  @JsonKey(name: "overview")
  String? overview;
  @JsonKey(name: "popularity")
  double? popularity;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "first_air_date")
  String? firstAirDate;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  TvSeries toEntity() {
    return TvSeries(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) =>
      _$TvSeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$TvSeriesModelToJson(this);

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
