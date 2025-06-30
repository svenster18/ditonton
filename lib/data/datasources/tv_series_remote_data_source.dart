import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeriesResponse
          .fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}