import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_images.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/add_task/controller/add_task_controller.dart';
import 'package:daily_do/widgets/custom_button.dart';
import 'package:daily_do/widgets/custom_textform_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddTaskScreen extends StatelessWidget {
  final AddTaskController controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: Scaffold(
                key: controller.scaffoldKey,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: kYellowColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(Icons.arrow_back)),
                                  SizedBox(height: 20),
                                  Text(
                                    "Create new task",
                                    style: TextStyles.labelPoppinsTextStyle()
                                        .copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: kBlackColor),
                                  ),
                                  SizedBox(height: 30),
                                  CustomTextFormField(
                                    focusNode: controller.taskFoc,
                                    controller: controller.titleCont,
                                    hintText: 'Add Title',
                                    hintStyle:
                                        TextStyles.labelPoppinsTextStyle()
                                            .copyWith(
                                                fontSize: 14,
                                                color: Colors.black54),
                                    borderColor: kBlackColor,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          focusNode: controller.dateFoc,
                                          controller: controller.dateCont,
                                          hintText: 'Select Date',
                                          isViewMode: true,
                                          hintStyle:
                                              TextStyles.labelPoppinsTextStyle()
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: Colors.black54),
                                          borderColor: kBlackColor,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.selectDate(context);
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kGreenColor),
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: kWhiteColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              focusNode: controller.timeFoc,
                              controller: controller.timeCont,
                              hintText: 'Select Time',
                              isViewMode: true,
                              onTap: () {
                                controller.selectTime(context);
                              },
                              suffixConstraints: BoxConstraints(),
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.access_time_rounded,
                                  size: 23,
                                ),
                              ),
                              hintStyle: TextStyles.labelPoppinsTextStyle()
                                  .copyWith(
                                      fontSize: 14, color: Colors.black54),
                              borderColor: kBlackColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              focusNode: controller.desFoc,
                              controller: controller.descCont,
                              hintText: 'Description',
                              maxLines: 5,
                              hintStyle: TextStyles.labelPoppinsTextStyle()
                                  .copyWith(
                                      fontSize: 14, color: Colors.black54),
                              borderColor: kBlackColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: kHintTextColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Categories",
                              style: TextStyles.labelPoppinsTextStyle()
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: kBlackColor),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: Get.height / 20,
                              child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    // Watch the selectedCategory to update the UI when it changes
                                    bool isSelected =
                                        controller.selectedCategory.value ==
                                            index;

                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectCategory(index);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? kGreenColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              index == 0
                                                  ? AppImages.houseIcon
                                                  : index == 1
                                                      ? AppImages.workingIcon
                                                      : AppImages.shoppingIcon,
                                              width: 29,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              index == 0
                                                  ? "Personal"
                                                  : index == 1
                                                      ? "Work"
                                                      : "Shopping",
                                              style: TextStyles
                                                      .labelPoppinsTextStyle()
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: isSelected
                                                          ? kWhiteColor
                                                          : kBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: kHintTextColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButtonWidget(
                              btnLabel: 'Add Task',
                              bgColor: kOrangeColor,
                              onTap: () {
                                controller.uploadTask();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
