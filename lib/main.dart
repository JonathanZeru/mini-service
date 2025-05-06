import 'dart:io' show Platform;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking/data/data_sources/test_source.dart';
import 'package:mini_service_booking/data/repositories/test_repository_impl.dart';
import 'package:mini_service_booking/domain/usecases/test_case.dart';
import 'package:mini_service_booking/presentation/controllers/test_controller.dart';
import 'package:mini_service_booking/utils/app_routes.dart';
import 'package:mini_service_booking/utils/bindings.dart';
import 'package:mini_service_booking/presentation/widgets/themes.dart';
import 'package:mini_service_booking/utils/initializer.dart';
import 'package:mini_service_booking/utils/network.dart';
import 'package:mini_service_booking/utils/storages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await ConfigPreference.init();

  final authStorage = HiveAuthStorage();
  final tokenPair = await authStorage.readTokens();
  final isLoggedIn = tokenPair != null && !tokenPair.access.isExpired();
  final connectivityResult = await Connectivity().checkConnectivity();

  // Load token if logged in
  if (isLoggedIn) {
    await NetworkHandler.loadTokenPair();
  }

  init();
  runApp(
    Platform.isAndroid || Platform.isIOS
        ? MyApp(isLoggedIn: isLoggedIn, connectivityResult: connectivityResult)
        : DevicePreview(
          builder:
              (context) => MyApp(
                isLoggedIn: isLoggedIn,
                connectivityResult: connectivityResult,
              ),
        ),
  );
}
void init() {
  final dataSource = TmdbRemoteDataSource();
  final repository = MovieRepositoryImpl(dataSource: dataSource);
  final getPopularMovies = GetPopularMovies(repository);

  Get.put(MovieController(getPopularMovies: getPopularMovies));
}
class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final List<ConnectivityResult> connectivityResult;
  const MyApp({
    super.key,
    required this.isLoggedIn,
    required this.connectivityResult,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstLaunch = ConfigPreference.isFirstLaunch();
    String initialRoute;

    if (isFirstLaunch) {
      initialRoute = AppRoutes.splash;
    } else if (isLoggedIn) {
      initialRoute = AppRoutes.mainLayout;
    } else {
      initialRoute = AppRoutes.signIn;
    }

    return GetMaterialApp(
      initialBinding: AppBindings(
        isLoggedIn: isLoggedIn,
        connectivityResult: connectivityResult,
      ), // Pass the login state
      debugShowCheckedModeBanner: false,
      title: 'Mini Service Booking',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.system,
      getPages: AppRoutes.pages,
      initialRoute: initialRoute,
    );
  }
}
