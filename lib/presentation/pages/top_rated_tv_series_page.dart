import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvSeriesNotifier>(context, listen: false)
            .fetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Center(child:
          Consumer<TopRatedTvSeriesNotifier>(builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return CircularProgressIndicator();
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvSeries = data.tvSeries[index];
              return TvSeriesCard(tvSeries);
            },
            itemCount: data.tvSeries.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      })),
    );
  }
}
