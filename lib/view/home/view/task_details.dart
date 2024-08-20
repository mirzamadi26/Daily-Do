import 'package:daily_do/models/task_model.dart';
import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_images.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/add_task/controller/add_task_controller.dart';
import 'package:daily_do/view/edit/view/edit_task.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:daily_do/widgets/custom_button.dart';
import 'package:daily_do/widgets/custom_scaffold.dart';
import 'package:daily_do/widgets/custom_textform_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TaskDetailsScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final task = Get.arguments as TaskModel;
  @override
  Widget build(BuildContext context) {
    final bool isTaskCompleted = task.status == 'Completed';
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        child: SafeArea(
          child: Scaffold(
            key: controller.scaffoldKeyTaskDetails,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.deleteTask(task.taskId);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    task.taskTitle,
                    style: TextStyles.labelPoppinsTextStyle().copyWith(
                        fontSize: 24,
                        decoration: isTaskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.w700,
                        color: kBlackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.taskDescription,
                    style: TextStyles.labelPoppinsTextStyle().copyWith(
                        fontSize: 18,
                        decoration: isTaskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor.withOpacity(0.7)),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: kFieldBorderColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Due",
                        style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 16,
                            decoration: isTaskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: kGreenColor),
                        child: Text(
                          task.status,
                          style: TextStyles.labelPoppinsTextStyle().copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kWhiteColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(task.dueDate,
                      style: TextStyles.labelPoppinsTextStyle().copyWith(
                          fontSize: 32,
                          decoration: isTaskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontWeight: FontWeight.w700,
                          color: kYellowColor)),
                  Text(task.time,
                      style: TextStyles.labelPoppinsTextStyle().copyWith(
                          fontSize: 20,
                          decoration: isTaskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          color: kYellowColor)),
                  SizedBox(height: 20),
                  Divider(
                    color: kFieldBorderColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Category",
                      style: TextStyles.labelPoppinsTextStyle().copyWith(
                          fontSize: 16,
                          decoration: isTaskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontWeight: FontWeight.w600,
                          color: kBlackColor)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: kGreenColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          task.category == 'Work'
                              ? AppImages.workingIcon
                              : task.category == 'Personal'
                                  ? AppImages.houseIcon
                                  : AppImages.shoppingIcon,
                          width: 29,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          task.category,
                          style: TextStyles.labelPoppinsTextStyle().copyWith(
                              fontSize: 14,
                              decoration: isTaskCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              color: kWhiteColor),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  !isTaskCompleted
                      ? CustomButtonWidget(
                          btnLabel: 'Edit Task',
                          bgColor: kGreenColor,
                          onTap: () {
                            Get.to(() => EditTaskScreen(task: task));
                          },
                          marginBottom: 5,
                        )
                      : SizedBox(),
                  !isTaskCompleted
                      ? CustomButtonWidget(
                          btnLabel: 'Mark as Complete',
                          bgColor: kOrangeColor,
                          onTap: () {
                            controller.updateTaskStatusToCompleted(task.taskId);
                          },
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        )));
  }
}
