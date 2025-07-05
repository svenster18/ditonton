// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvSeriesDetailResponse _$TvSeriesDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TvSeriesDetailResponse(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String,
      id: (json['id'] as num).toInt(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String,
      firstAirDate: json['first_air_date'] as String,
      status: json['status'] as String,
      tagline: json['tagline'] as String,
      name: json['name'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$TvSeriesDetailResponseToJson(
        TvSeriesDetailResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genres': instance.genres,
      'homepage': instance.homepage,
      'id': instance.id,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate,
      'status': instance.status,
      'tagline': instance.tagline,
      'name': instance.name,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
