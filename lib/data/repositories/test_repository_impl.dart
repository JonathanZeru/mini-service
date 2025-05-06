
import 'package:mini_service_booking/data/data_sources/test_source.dart';
import 'package:mini_service_booking/data/model/test.dart';
import 'package:mini_service_booking/data/model/test1.dart';
import 'package:mini_service_booking/data/repositories/test_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final TmdbRemoteDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>> getPopularMovies() async {
    final results = await dataSource.getPopularMovies();
    return results.map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>).toEntity()).toList();
  }
}
