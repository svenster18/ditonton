// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ditonton/common/constants.dart';
// import 'package:ditonton/domain/entities/movie.dart';
// import 'package:ditonton/presentation/pages/about_page.dart';
// import 'package:ditonton/presentation/pages/movie_detail_page.dart';
// import 'package:ditonton/presentation/pages/search_page.dart';
// import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class HomeTvSeriesPage extends StatefulWidget {
//   @override
//   _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
// }
//
// class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(
//             () => Provider.of<TvSeriesListNotifier>(context, listen: false)
//           ..fetchOnTheAirTvSeries()
//           ..fetchPopularTvSeries()
//           ..fetchTopRatedTvSeries());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage('assets/circle-g.png'),
//                 backgroundColor: Colors.grey.shade900,
//               ),
//               accountName: Text('Ditonton'),
//               accountEmail: Text('ditonton@dicoding.com'),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade900,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.movie),
//               title: Text('TvSeries'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.save_alt),
//               title: Text('Watchlist'),
//               onTap: () {
//                 Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
//               },
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
//               },
//               leading: Icon(Icons.info_outline),
//               title: Text('About'),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: Text('Ditonton'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
//             },
//             icon: Icon(Icons.search),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Now Playing',
//                 style: kHeading6,
//               ),
//               Consumer<MovieListNotifier>(builder: (context, data, child) {
//                 final state = data.nowPlayingState;
//                 if (state == RequestState.Loading) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state == RequestState.Loaded) {
//                   return MovieList(data.nowPlayingTvSeries);
//                 } else {
//                   return Text('Failed');
//                 }
//               }),
//               _buildSubHeading(
//                 title: 'Popular',
//                 onTap: () =>
//                     Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
//               ),
//               Consumer<MovieListNotifier>(builder: (context, data, child) {
//                 final state = data.popularTvSeriesState;
//                 if (state == RequestState.Loading) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state == RequestState.Loaded) {
//                   return MovieList(data.popularTvSeries);
//                 } else {
//                   return Text('Failed');
//                 }
//               }),
//               _buildSubHeading(
//                 title: 'Top Rated',
//                 onTap: () =>
//                     Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
//               ),
//               Consumer<MovieListNotifier>(builder: (context, data, child) {
//                 final state = data.topRatedTvSeriesState;
//                 if (state == RequestState.Loading) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state == RequestState.Loaded) {
//                   return MovieList(data.topRatedTvSeries);
//                 } else {
//                   return Text('Failed');
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row _buildSubHeading({required String title, required Function() onTap}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: kHeading6,
//         ),
//         InkWell(
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class MovieList extends StatelessWidget {
//   final List<Movie> tvSeries;
//
//   MovieList(this.tvSeries);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           final movie = tvSeries[index];
//           return Container(
//             padding: const EdgeInsets.all(8),
//             child: InkWell(
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   MovieDetailPage.ROUTE_NAME,
//                   arguments: movie.id,
//                 );
//               },
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 child: CachedNetworkImage(
//                   imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
//                   placeholder: (context, url) => Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 ),
//               ),
//             ),
//           );
//         },
//         itemCount: tvSeries.length,
//       ),
//     );
//   }
// }
