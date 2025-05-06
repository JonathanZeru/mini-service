import 'package:mini_service_booking/utils/localization_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storages.g.dart';

const authTokenStorage = 'auth_token_storage';

@JsonSerializable()
@HiveType(typeId: 9) // Ensure Hive recognizes this type
class Token {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final DateTime iss;

  @HiveField(2)
  final DateTime exp;

  Token({required this.token, required this.iss, required this.exp});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  bool isExpired() {
    return DateTime.now().isAfter(exp);
  }
}

@JsonSerializable()
@HiveType(typeId: 10) // Ensure Hive recognizes this type
class TokenPair {
  @HiveField(0)
  final Token access;

  @HiveField(1)
  final Token refresh;

  TokenPair({required this.access, required this.refresh});

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);

  Map<String, dynamic> toJson() => _$TokenPairToJson(this);
}

abstract class AuthStorage {
  Future<TokenPair?> readTokens();
  Future<void> writeTokens(TokenPair pair);
  Future<void> clear();
  void listen(void Function(BoxEvent) boxEvenHandler);
}

class HiveAuthStorage extends AuthStorage {
  @override
  Future<TokenPair?> readTokens() async {
    final box = Hive.box<TokenPair>(authTokenStorage);
    return box.get(authTokenStorage);
  }

  @override
  Future<void> writeTokens(TokenPair pair) async {
    final box = Hive.box<TokenPair>(authTokenStorage);
    await box.put(authTokenStorage, pair);
  }

  @override
  void listen(void Function(BoxEvent event) boxEvenHandler) {
    final box = Hive.box<TokenPair>(authTokenStorage);
    box.watch(key: authTokenStorage).listen(boxEvenHandler);
  }

  @override
  Future<void> clear() async {
    final box = Hive.box<TokenPair>(authTokenStorage);
    await box.delete(authTokenStorage);
  }
}

class TokenTypeAdapter extends TypeAdapter<Token> {
  @override
  final int typeId = 9; // Unique ID for Token

  @override
  Token read(BinaryReader reader) {
    return Token(
      token: reader.readString(),
      iss: DateTime.parse(reader.readString()),
      exp: DateTime.parse(reader.readString()),
    );
  }

  @override
  void write(BinaryWriter writer, Token obj) {
    writer.writeString(obj.token);
    writer.writeString(obj.iss.toIso8601String());
    writer.writeString(obj.exp.toIso8601String());
  }
}

class TokenPairTypeAdapter extends TypeAdapter<TokenPair> {
  @override
  final int typeId = 10; // Unique ID for TokenPair

  @override
  TokenPair read(BinaryReader reader) {
    return TokenPair(
      access: reader.read() as Token,
      refresh: reader.read() as Token,
    );
  }

  @override
  void write(BinaryWriter writer, TokenPair obj) {
    writer.write(obj.access);
    writer.write(obj.refresh);
  }
}

class ConfigPreference {
  // Prevent instantiation
  ConfigPreference._();

  static const String _preferencesBox = 'preferences';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _isFirstLaunchKey = 'is_first_launch';
  static const String _userProfileKey = 'user_profile';

  static RxBool hasConnection = true.obs;

  // Initialize Hive
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    await Hive.openBox<dynamic>(_preferencesBox);
  }

  // Get Hive box
  static Box<dynamic> _getBox() {
    return Hive.box(_preferencesBox);
  }

  // Set theme to light/dark
  static Future<void> setThemeIsLight(bool lightTheme) async {
    await _getBox().put(_lightThemeKey, lightTheme);
  }

  // Get current theme (light or dark)
  static bool getThemeIsLight() {
    return _getBox().get(_lightThemeKey, defaultValue: true) as bool;
  }

  // Save current language
  static Future<void> setCurrentLanguage(String languageCode) async {
    await _getBox().put(_currentLocalKey, languageCode);
  }

  // Get current language
  static Locale getCurrentLocal() {
    String? langCode = _getBox().get(_currentLocalKey) as String?;
    return langCode == null
        ? LocalizationManager.defaultLanguage
        : LocalizationManager.supportedLanguages[langCode]!;
  }

  // Check if it's the first launch
  static bool isFirstLaunch() {
    return _getBox().get(_isFirstLaunchKey, defaultValue: true) as bool;
  }

  // Mark the app as launched
  static Future<void> markAppLaunched() async {
    await _getBox().put(_isFirstLaunchKey, false);
  }

  // Store user profile
  static Future<void> storeUserProfile(Map<String, dynamic> userProfile) async {
    await _getBox().put(_userProfileKey, userProfile);
  }

  // Get user profile
  static Map<String, dynamic>? getUserProfile() {
    return _getBox().get(_userProfileKey) as Map<String, dynamic>?;
  }

  // Clear all stored data
  static Future<void> clear() async {
    await _getBox().clear();
  }
}
