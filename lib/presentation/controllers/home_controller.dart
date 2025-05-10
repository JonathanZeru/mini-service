import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/usecases/get_categories.dart';
import 'package:service_booking_app/domain/usecases/get_services.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class HomeController extends GetxController {
  final GetServices getServices;
  final GetCategories getCategories;

  HomeController({
    required this.getServices,
    required this.getCategories,
  });

  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final RxList<ServiceModel> filteredServices = <ServiceModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategoryId = 'All'.obs;
  final RxBool filterAvailableOnly = false.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 10000.0.obs;
  final RxDouble selectedMinPrice = 0.0.obs;
  final RxDouble selectedMaxPrice = 10000.0.obs;
  final RxDouble minRating = 0.0.obs;
  final RxDouble selectedRating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchServices();
  }

  Future<void> fetchCategories() async {
    final result = await getCategories();
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        categories.value = data;
      },
    );
  }

  Future<void> fetchServices() async {
    isLoading.value = true;
    
    // Apply filters
    String? categoryId = selectedCategoryId.value == 'All' ? null : selectedCategoryId.value;
    bool? availability = filterAvailableOnly.value ? true : null;
    double? minPriceFilter = selectedMinPrice.value > minPrice.value ? selectedMinPrice.value : null;
    double? maxPriceFilter = selectedMaxPrice.value < maxPrice.value ? selectedMaxPrice.value : null;
    double? ratingFilter = selectedRating.value > 0 ? selectedRating.value : null;
    
    final result = await getServices(
      categoryId: categoryId,
      availability: availability,
      // We can't directly filter by price range in the API, so we'll filter the results
    );
    
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        services.value = data;
        
        // Apply client-side filtering for price range if needed
        if (minPriceFilter != null || maxPriceFilter != null) {
          services.value = services.where((service) {
            bool passesMinPrice = minPriceFilter == null || service.price >= minPriceFilter;
            bool passesMaxPrice = maxPriceFilter == null || service.price <= maxPriceFilter;
            return passesMinPrice && passesMaxPrice;
          }).toList();
        }
        
        // Find min and max prices for the range slider
        if (services.isNotEmpty) {
          final prices = services.map((s) => s.price).toList();
          minPrice.value = prices.reduce((a, b) => a < b ? a : b);
          maxPrice.value = prices.reduce((a, b) => a > b ? a : b);
          
          // Initialize selected values if they're outside the range
          if (selectedMinPrice.value < minPrice.value) {
            selectedMinPrice.value = minPrice.value;
          }
          if (selectedMaxPrice.value > maxPrice.value) {
            selectedMaxPrice.value = maxPrice.value;
          }
        }
        
        filterServices();
      },
    );
    
    isLoading.value = false;
  }

  void filterServices() {
    final query = searchQuery.value.toLowerCase();
    
    filteredServices.value = services.where((service) {
      // Text search
      final matchesQuery = service.name.toLowerCase().contains(query);
      
      // Category filter
      final matchesCategory = selectedCategoryId.value == 'All' || 
                             service.categoryId == selectedCategoryId.value;
      
      // Availability filter
      final matchesAvailability = !filterAvailableOnly.value || service.availability;
      
      // Price range filter
      final matchesPriceRange = service.price >= selectedMinPrice.value && 
                               service.price <= selectedMaxPrice.value;
      
      // Rating filter
      final matchesRating = service.rating >= selectedRating.value;
      
      return matchesQuery && matchesCategory && matchesAvailability && 
             matchesPriceRange && matchesRating;
    }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterServices();
  }

  void updateSelectedCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
    filterServices();
  }

  void updateAvailabilityFilter(bool value) {
    filterAvailableOnly.value = value;
    filterServices();
  }

  void updatePriceRange(double min, double max) {
    selectedMinPrice.value = min;
    selectedMaxPrice.value = max;
    filterServices();
  }

  void updateRatingFilter(double rating) {
    selectedRating.value = rating;
    filterServices();
  }

  void resetFilters() {
    searchQuery.value = '';
    selectedCategoryId.value = 'All';
    filterAvailableOnly.value = false;
    selectedMinPrice.value = minPrice.value;
    selectedMaxPrice.value = maxPrice.value;
    selectedRating.value = 0.0;
    filterServices();
  }

  void goToServiceDetails(String id) {
    Get.toNamed(Routes.serviceDetails, arguments: id);
  }

  void goToCreateService() {
    Get.toNamed(Routes.createService);
  }

  void goToCategories() {
    Get.toNamed(Routes.categories);
  }

  void refreshServices() {
    fetchServices();
  }
}
