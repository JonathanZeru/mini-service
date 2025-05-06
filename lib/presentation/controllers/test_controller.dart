import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mini_service_booking/data/model/test1.dart';
import 'package:mini_service_booking/domain/usecases/test_case.dart';

class MovieController extends GetxController {
  final GetPopularMovies getPopularMovies;

  MovieController({required this.getPopularMovies});

  var movies = <Movie>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPopularMovies();
    super.onInit();
  }

  Future<void> fetchPopularMovies() async {
    try {
      isLoading(true);
      final result = await getPopularMovies.execute();
      movies.value = result;
    } finally {
      isLoading(false);
    }
  }
}