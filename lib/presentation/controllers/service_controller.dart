import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/usecases/delete_service.dart';
import 'package:service_booking_app/domain/usecases/get_service.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class ServiceController extends GetxController {
  final GetService getService;
  final DeleteService deleteService;

  ServiceController({
    required this.getService,
    required this.deleteService,
  });

  final Rx<ServiceModel?> service = Rx<ServiceModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String serviceId = Get.arguments as String;
    fetchService(serviceId);
  }

  Future<void> fetchService(String id) async {
    isLoading.value = true;
    final result = await getService(id);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        service.value = data;
      },
    );
    isLoading.value = false;
  }

  void goToEditService() {
    if (service.value != null) {
      Get.toNamed(
        Routes.editService,
        arguments: service.value!.id,
      );
    }
  }

  Future<void> confirmDelete() async {
    UIHelpers.showConfirmationDialog(
      title: 'Delete Service',
      message: 'Are you sure you want to delete this service? This action cannot be undone.',
      confirmText: 'Delete',
      onConfirm: () => performDelete(),
    );
  }

  Future<void> performDelete() async {
    if (service.value?.id == null) return;
    
    isDeleting.value = true;
    final result = await deleteService(service.value!.id!);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (_) {
        UIHelpers.showSnackbar(
          title: 'Success',
          message: 'Service deleted successfully',
          isError: false,
        );
          try {
            final homeController = Get.find<HomeController>();
            homeController.fetchServices().then((_) {
              Get.until((route) => route.settings.name == Routes.home);
            });
          } catch (e) {
            Get.until((route) => route.settings.name == Routes.home);
          }
      },
    );
    isDeleting.value = false;
  }

  void refreshService() {
    if (service.value?.id != null) {
      fetchService(service.value!.id!);
    }
  }
}
