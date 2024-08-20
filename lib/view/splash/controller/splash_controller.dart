import 'package:daily_do/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeySplashScreen = GlobalKey<ScaffoldState>();

  void checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      try {
        if (FirebaseAuth.instance.currentUser != null) {
          Get.offAndToNamed(homeScreen);
        } else {
          Get.offAndToNamed(signInView);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkUserStatus();
  }
}
