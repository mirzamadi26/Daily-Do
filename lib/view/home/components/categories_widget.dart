import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_images.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:daily_do/view/home/view/task_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 5.6,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String category;
          String icon;

          if (index == 0) {
            category = "Work";
            icon = AppImages.workingIcon;
          } else if (index == 1) {
            category = "Personal";
            icon = AppImages.houseIcon;
          } else {
            category = "Shopping";
            icon = AppImages.shoppingIcon;
          }
          return GetBuilder<HomeController>(
            builder: (controller) {
              int taskCount = controller.getTaskCountByCategory(category);

              return GestureDetector(
                onTap: () {
                  Get.to(() => TaskCategoryScreen(category: category));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: Get.width / 2.5,
                    height: Get.height / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index == 0
                          ? kGreenColor.withOpacity(0.7)
                          : index == 1
                              ? kYellowColor.withOpacity(0.8)
                              : kOrangeColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          icon,
                          width: 50,
                        ),
                        Text(
                          category,
                          style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor,
                          ),
                        ),
                        Text(
                          "$taskCount Tasks",
                          style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
