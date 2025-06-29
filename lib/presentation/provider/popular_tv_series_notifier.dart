import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';

class PopularTvSeriesNotifier extends ChangeNotifier {
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;
}