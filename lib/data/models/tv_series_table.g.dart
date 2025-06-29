// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvSeriesTable _$TvSeriesTableFromJson(Map<String, dynamic> json) =>
    TvSeriesTable(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      posterPath: json['posterPath'] as String?,
      overview: json['overview'] as String?,
    );

Map<String, dynamic> _$TvSeriesTableToJson(TvSeriesTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'posterPath': instance.posterPath,
      'overview': instance.overview,
    };
