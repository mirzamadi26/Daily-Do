import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:daily_do/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(
              Icons.format_quote_rounded,
              color: kGreenColor,
            ),
            onTap: () {
              controller.fetchQuote();
              Get.back();
              Get.defaultDialog(
                  title: 'Random Quote',
                  content: Obx(() {
                    if (controller.isLoading.value) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        textAlign: TextAlign.justify,
                        controller.quote.value,
                        style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 14,
                            color: kYellowColor,
                            fontWeight: FontWeight.bold),
                      );
                    }
                  }),
                  confirm: SizedBox(
                    width: Get.width / 2,
                    child: CustomButtonWidget(
                      btnLabel: 'Close',
                      onTap: () {
                        Get.close(1);
                      },
                    ),
                  ));
            },
            title: Text(
              'Random Quote',
              style: TextStyles.labelPoppinsTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: kGreenColor,
            ),
            title: Text(
              'Logout',
              style: TextStyles.labelPoppinsTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              controller.logout(); // Close the drawer
              Get.snackbar("Logout", "You have been logged out successfully");
              // Add your logout logic here
            },
          ),
        ],
      ),
    );
  }
}
