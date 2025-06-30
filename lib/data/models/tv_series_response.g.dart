// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvSeriesResponse _$TvSeriesResponseFromJson(Map<String, dynamic> json) =>
    TvSeriesResponse(
      (json['results'] as List<dynamic>)
          .map((e) => TvSeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvSeriesResponseToJson(TvSeriesResponse instance) =>
    <String, dynamic>{
      'results': instance.tvSeriesList,
    };
