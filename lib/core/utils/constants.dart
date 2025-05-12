class Constants {
  // API Endpoints
  static const String apiBaseUrl =
      'https://681dcee2c1c291fa6631c080.mockapi.io';
  static const String categoriesEndpoint = '/category';
  static const String servicesEndpoint = '/service';

  // Validation
  static const int maxNameLength = 50;
  static const double minPrice = 0;
  static const double maxPrice = 10000;
  static const int minDuration = 5;
  static const int maxDuration = 480; // 8 hours
  static const double minRating = 0;
  static const double maxRating = 5;
}
