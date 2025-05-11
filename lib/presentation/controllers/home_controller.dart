import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_categories.dart';
import 'package:service_booking_app/domain/usecases/get_services.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class HomeController extends GetxController {
  final GetServices getServices;
  final GetCategories getCategories;
  final DeleteCategory deleteCategory;
  final AuthController authController;

  HomeController({
    required this.getServices,
    required this.getCategories,
    required this.deleteCategory,
    required this.authController,
  });


 // Tab navigation
  final RxInt currentIndex = 0.obs;

  // Services tab
  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final RxList<ServiceModel> filteredServices = <ServiceModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreServices = true.obs;
  final RxInt currentServicesPage = 1.obs;
  final RxString searchQuery = ''.obs;
  final Rx<String?> selectedCategoryId = Rx<String?>(null);
  final RxBool filterAvailableOnly = false.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 10000.0.obs;
  final RxDouble selectedMinPrice = 0.0.obs;
  final RxDouble selectedMaxPrice = 10000.0.obs;
  final RxDouble minRating = 0.0.obs;
  final RxDouble selectedRating = 0.0.obs;
  final int servicesPerPage = 5;

  // Categories tab
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;
  final RxBool isCategoriesLoading = false.obs;
  final RxBool isLoadingMoreCategories = false.obs;
  final RxBool hasMoreCategories = true.obs;
  final RxInt currentCategoriesPage = 1.obs;
  final RxString categorySearchQuery = ''.obs;
  final int categoriesPerPage = 5;

  bool get isAdmin => authController.isAdmin;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchServices();
  }

  // Tab navigation
  void changeTab(int index) {
    currentIndex.value = index;
  }

  // Services methods
  // Services methods
  Future<void> fetchServices({bool refresh = true}) async {
    if (refresh) {
      isLoading.value = true;
      currentServicesPage.value = 1;
      services.clear();
      hasMoreServices.value = true;
    }
    
    // Apply filters
    String? categoryId = selectedCategoryId.value == 'All' ? null : selectedCategoryId.value;
    bool? availability = filterAvailableOnly.value ? true : null;
    double? minPriceFilter = selectedMinPrice.value > minPrice.value ? selectedMinPrice.value : null;
    double? maxPriceFilter = selectedMaxPrice.value < maxPrice.value ? selectedMaxPrice.value : null;
    double? ratingFilter = selectedRating.value > 0 ? selectedRating.value : null;
    
    final result = await getServices(
      categoryId: categoryId,
      availability: availability,
      page: currentServicesPage.value,
      limit: servicesPerPage,
    );
    
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        if (refresh) {
          services.value = data;
        } else {
          services.addAll(data);
        }
        
        // Check if we've reached the end of the list
        if (data.length < servicesPerPage) {
          hasMoreServices.value = false;
        }
        
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
    
    if (refresh) {
      isLoading.value = false;
    } else {
      isLoadingMore.value = false;
    }
  }
   Future<void> loadMoreServices() async {
    if (isLoadingMore.value || !hasMoreServices.value) return;
    
    isLoadingMore.value = true;
    currentServicesPage.value++;
    await fetchServices(refresh: false);
  }
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterServices();
  }

  void filterServices() {
  final query = searchQuery.value.toLowerCase();
  
  filteredServices.value = services.where((service) {
    // Text search
    final matchesQuery = service.name.toLowerCase().contains(query);
    
    // Category filter - null means show all categories
    final matchesCategory = selectedCategoryId.value == null || 
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

void resetFilters() {
  searchQuery.value = '';
  selectedCategoryId.value = null; // Changed from 'All' to null
  filterAvailableOnly.value = false;
  selectedMinPrice.value = minPrice.value;
  selectedMaxPrice.value = maxPrice.value;
  selectedRating.value = 0.0;
  
  // Optional: refresh services from API if needed
  fetchServices(refresh: true);
  
  // Apply the filters immediately
  filterServices();
}
  // Update the category selection method
  void updateSelectedCategory(String? categoryId) {
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

  void refreshServices() {
    fetchServices();
  }

  // Categories methods
  // Categories methods
  Future<void> fetchCategories({bool refresh = true}) async {
    if (refresh) {
      isCategoriesLoading.value = true;
      currentCategoriesPage.value = 1;
      categories.clear();
      hasMoreCategories.value = true;
    }
    
    final result = await getCategories(
      page: currentCategoriesPage.value,
      limit: categoriesPerPage,
    );
    
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        if (refresh) {
          categories.value = data;
        } else {
          categories.addAll(data);
        }
        
        // Check if we've reached the end of the list
        if (data.length < categoriesPerPage) {
          hasMoreCategories.value = false;
        }
        
        filterCategories();
      },
    );
    
    if (refresh) {
      isCategoriesLoading.value = false;
    } else {
      isLoadingMoreCategories.value = false;
    }
  }

  Future<void> loadMoreCategories() async {
    if (isLoadingMoreCategories.value || !hasMoreCategories.value) return;
    
    isLoadingMoreCategories.value = true;
    currentCategoriesPage.value++;
    await fetchCategories(refresh: false);
  }
  void filterCategories() {
    final query = categorySearchQuery.value.toLowerCase();
    
    filteredCategories.value = categories.where((category) {
      return category.name.toLowerCase().contains(query) ||
          category.description.toLowerCase().contains(query);
    }).toList();
  }
  void updateCategorySearchQuery(String query) {
    categorySearchQuery.value = query;
    filterCategories();
  }

  void refreshCategories() {
    fetchCategories();
  }

  Future<void> confirmDeleteCategory(String id) async {
    UIHelpers.showConfirmationDialog(
      title: 'delete_category'.tr,
      message: 'delete_category_confirm'.tr,
      confirmText: 'delete'.tr,
      onConfirm: () => performDeleteCategory(id),
    );
  }

  Future<void> performDeleteCategory(String id) async {
    isCategoriesLoading.value = true;
    final result = await deleteCategory(id);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (_) {
        UIHelpers.showSnackbar(
          title: 'success'.tr,
          message: 'category_deleted'.tr,
          isError: false,
        );
        fetchCategories();
      },
    );
    isCategoriesLoading.value = false;
  }

  // Navigation methods
  void goToServiceDetails(String id) {
    Get.toNamed(Routes.serviceDetails, arguments: id);
  }

  void goToCreateService() {
    Get.toNamed(Routes.createService);
  }

  void goToCategoryDetails(String id) {
    Get.toNamed(Routes.categoryDetails, arguments: id);
  }

  void goToCreateCategory() {
    Get.toNamed(Routes.createCategory);
  }
}
