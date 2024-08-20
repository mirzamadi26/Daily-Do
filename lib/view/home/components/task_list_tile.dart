import 'package:daily_do/models/task_model.dart';
import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksListTile extends StatelessWidget {
  const TasksListTile(
      {super.key, required this.task, required this.isTaskCompleted});
  final TaskModel task;
  final bool isTaskCompleted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: Get.width / 1.5,
        decoration: BoxDecoration(
            border: Border.all(color: kFieldBorderColor),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.taskTitle,
                style: TextStyles.labelPoppinsTextStyle().copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    decoration: isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: kBlackColor),
              ),
              Text(
                task.taskDescription,
                style: TextStyles.labelPoppinsTextStyle().copyWith(
                    fontSize: 15,
                    decorationColor: Colors.black,
                    decoration: isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor.withOpacity(0.7)),
              ),
              Divider(
                color: kHintTextColor,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Due",
                        style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            decoration: isTaskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: kBlackColor.withOpacity(0.9)),
                      ),
                      Text(
                        "${task.dueDate} (${task.time})",
                        style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 14,
                            decoration: isTaskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontWeight: FontWeight.w400,
                            color: kYellowColor),
                      ),
                    ],
                  ),
                  Spacer(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
