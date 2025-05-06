
import 'package:mini_service_booking/data/model/test1.dart' show Movie;
import 'package:mini_service_booking/data/repositories/test_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<List<Movie>> execute() async {
    return await repository.getPopularMovies();
  }
}