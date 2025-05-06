import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking/utils/app_routes.dart';
import 'package:mini_service_booking/utils/storages.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> isUserLoggedIn() async {
    final box = await Hive.openBox<TokenPair>(authTokenStorage);
    final tokenPair = box.get(authTokenStorage);
    return tokenPair != null && !tokenPair.access.isExpired();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () async {
      ConfigPreference.markAppLaunched();
      if (await isUserLoggedIn()) {
        Get.offAllNamed<void>(AppRoutes.mainLayout); // If signed in, go to Home
      } else {
        Get.offAllNamed<void>(
          AppRoutes.signIn,
        ); // If not signed in, go to Sign-In
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/gibe-market-logo.png", width: 150, height: 150),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Gibe Market!\nYour best shopping experience starts here.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
