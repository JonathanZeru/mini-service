import 'package:get/get.dart';
import 'package:mini_service_booking/presentation/pages/splash.dart';

class AppRoutes {
  AppRoutes._();
  static final splash = '/splash';

  static final signIn = '/signIn';
  static final signUp = '/signUp';

  static final mainLayout = '/main_layout';

  static final home = '/home';
  static final category = '/category';
  static final cart = '/cart';
  static final order = '/order';

  static final productDetail = '/product-detail';
  static final allProducts = '/all-products';

  static final editProfile = '/edit-profile';

  static final pages = [
    GetPage<SplashScreen>(name: splash, page: () => SplashScreen()),

  ];
}
