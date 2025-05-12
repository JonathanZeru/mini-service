import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/data/models/user_model.dart';

class HiveManager {
  static const String categoriesBox = 'categories';
  static const String servicesBox = 'services';
  static const String userBox = 'user';
  static const String settingsBox = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(categoriesBox);
    await Hive.openBox<String>(servicesBox);
    await Hive.openBox<String>(userBox);
    await Hive.openBox<String>(settingsBox);
  }

  // Categories methods
  static Future<void> saveCategories(List<CategoryModel> categories) async {
    final box = Hive.box<String>(categoriesBox);
    final categoriesJson =
        categories.map((c) => jsonEncode(c.toJson())).toList();
    await box.put('all_categories', jsonEncode(categoriesJson));
  }

  static Future<List<CategoryModel>> getCategories() async {
    final box = Hive.box<String>(categoriesBox);
    final categoriesJson = box.get('all_categories');
    if (categoriesJson == null) return [];

    final List<dynamic> decodedList =
        jsonDecode(categoriesJson) as List<dynamic>;
    return decodedList
        .map(
          (c) => CategoryModel.fromJson(
            jsonDecode(c as String) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  static Future<void> saveCategory(CategoryModel category) async {
    final box = Hive.box<String>(categoriesBox);
    await box.put(category.id!, jsonEncode(category.toJson()));
  }

  static Future<CategoryModel?> getCategory(String id) async {
    final box = Hive.box<String>(categoriesBox);
    final categoryJson = box.get(id);
    if (categoryJson == null) return null;

    return CategoryModel.fromJson(
      jsonDecode(categoryJson) as Map<String, dynamic>,
    );
  }

  static Future<void> deleteCategory(String id) async {
    final box = Hive.box<String>(categoriesBox);
    await box.delete(id);
  }

  // Services methods
  static Future<void> saveServices(List<ServiceModel> services) async {
    final box = Hive.box<String>(servicesBox);
    final servicesJson = services.map((s) => jsonEncode(s.toJson())).toList();
    await box.put('all_services', jsonEncode(servicesJson));
  }

  static Future<List<ServiceModel>> getServices() async {
    final box = Hive.box<String>(servicesBox);
    final servicesJson = box.get('all_services');
    if (servicesJson == null) return [];

    final List<dynamic> decodedList = jsonDecode(servicesJson) as List;
    return decodedList
        .map(
          (s) => ServiceModel.fromJson(
            jsonDecode(s as String) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  static Future<void> saveService(ServiceModel service) async {
    final box = Hive.box<String>(servicesBox);
    await box.put(service.id!, jsonEncode(service.toJson()));
  }

  static Future<ServiceModel?> getService(String id) async {
    final box = Hive.box<String>(servicesBox);
    final serviceJson = box.get(id);
    if (serviceJson == null) return null;

    return ServiceModel.fromJson(
      jsonDecode(serviceJson) as Map<String, dynamic>,
    );
  }

  static Future<void> deleteService(String id) async {
    final box = Hive.box<String>(servicesBox);
    await box.delete(id);
  }

  // User methods
  static Future<void> saveUser(UserModel user) async {
    final box = Hive.box<String>(userBox);
    await box.put('current_user', jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    final box = Hive.box<String>(userBox);
    final userJson = box.get('current_user');
    if (userJson == null) return null;

    return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
  }

  static Future<void> deleteUser() async {
    final box = Hive.box<String>(userBox);
    await box.delete('current_user');
  }

  // Settings methods
  static Future<void> saveLanguage(String languageCode) async {
    final box = Hive.box<String>(settingsBox);
    await box.put('language', languageCode);
  }

  static Future<String> getLanguage() async {
    final box = Hive.box<String>(settingsBox);
    return box.get('language') ?? 'en';
  }

  static Future<void> saveThemeMode(String themeMode) async {
    final box = Hive.box<String>(settingsBox);
    await box.put('theme_mode', themeMode);
  }

  static Future<String> getThemeMode() async {
    final box = Hive.box<String>(settingsBox);
    return box.get('theme_mode') ?? 'system';
  }

  static Future<void> clearAll() async {
    final categoriesBoxInstance = Hive.box<String>(categoriesBox);
    final servicesBoxInstance = Hive.box<String>(servicesBox);
    final userBoxInstance = Hive.box<String>(userBox);

    await categoriesBoxInstance.clear();
    await servicesBoxInstance.clear();
    await userBoxInstance.clear();
  }
}
