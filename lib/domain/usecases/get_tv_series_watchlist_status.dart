import '../repositories/tv_series_repository.dart';

class GetTvSeriesWatchlistStatus {
  final TvSeriesRepository repository;

  GetTvSeriesWatchlistStatus(this.repository);
  Future<bool> execute(int i) {
    return repository.isAddedToWatchlist(i);
  }
}