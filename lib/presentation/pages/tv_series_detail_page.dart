import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../domain/entities/tv_series.dart';
import '../provider/tv_series_detail_notifier.dart';

class TvSeriesDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-series-detail';

  final int id;

  TvSeriesDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<TvSeriesDetailNotifier>(builder: (context, provider, child) {
        final tvSeries = provider.tvSeries;
        return SafeArea(
          child: DetailContent(
            tvSeries,
            provider.tvSeriesRecommendations,
            provider.isAddedToWatchlist,
          ),
        );
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
      this.tvSeries, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: kRichBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvSeries.name,
                            style: kHeading5,
                          ),
                          FilledButton(
                            onPressed: () async {
                              if (!isAddedWatchlist) {
                                await Provider.of<TvSeriesDetailNotifier>(
                                        context,
                                        listen: false)
                                    .addWatchlist(tvSeries);
                              } else {
                                await Provider.of<TvSeriesDetailNotifier>(
                                        context,
                                        listen: false)
                                    .removeFromWatchlist(tvSeries);
                              }

                              final message =
                                  Provider.of<TvSeriesDetailNotifier>(context,
                                          listen: false)
                                      .watchlistMessage;

                              if (message ==
                                      TvSeriesDetailNotifier
                                          .watchlistAddSuccessMessage ||
                                  message ==
                                      TvSeriesDetailNotifier
                                          .watchlistRemoveSuccessMessage) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    });
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isAddedWatchlist
                                    ? Icon(Icons.check)
                                    : Icon(Icons.add),
                                Text('Watchlist'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
