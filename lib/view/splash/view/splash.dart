import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_images.dart';
import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/utils/form_validators.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/auth/controller/auth_controller.dart';
import 'package:daily_do/view/splash/controller/splash_controller.dart';
import 'package:daily_do/widgets/custom_button.dart';
import 'package:daily_do/widgets/custom_textform_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SplashScreen extends GetView<AuthController> {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: controller.scaffoldKeySplashScreen,
          body: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Opacity(
                  opacity: 0.3, // Set your desired opacity value
                  child: Image.asset(
                    AppImages.bgImage,
                    fit: BoxFit
                        .cover, // Use BoxFit.cover to fill the entire screen
                  ),
                ),
                Center(
                  // Center the text
                  child: Text(
                    "Daily Do",
                    style: TextStyles.labelStyleText().copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: kGreenColor),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
