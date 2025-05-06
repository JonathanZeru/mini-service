import 'package:mini_service_booking/utils/storages.dart';
import 'package:mini_service_booking/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initialize() async {
  await Hive.initFlutter();

  // Register the adapters for both Token and TokenPair
  if (!Hive.isAdapterRegistered(9)) {
    Hive.registerAdapter<Token>(TokenTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(10)) {
    Hive.registerAdapter<TokenPair>(TokenPairTypeAdapter());
  }

  await Hive.openBox<TokenPair>(authTokenStorage);
  logger.i('Initializing The application');

  // Debug: Ensure data integrity
  final box = Hive.box<TokenPair>(authTokenStorage);
}

Future<void> preStartTasks() async {
  // Clear storage if needed (Uncomment if necessary)
  // await Hive.deleteFromDisk();
}
