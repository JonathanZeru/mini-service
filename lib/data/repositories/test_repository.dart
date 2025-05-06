import 'package:mini_service_booking/data/model/test1.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies();
}