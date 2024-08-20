import 'package:daily_do/models/task_model.dart';
import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/home/components/category_task_tile.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCategoryScreen extends StatelessWidget {
  final String category;

  TaskCategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final HomeController taskController = Get.find();

    // Get tasks for the selected category
    final List<TaskModel> tasksInCategory = taskController.tasks
        .where((task) => task.category == category)
        .toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kYellowColor,
          centerTitle: true,
          title: Text(
            '$category Tasks',
            style: TextStyles.appBarInterTextStyle().copyWith(fontSize: 22),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: tasksInCategory.isEmpty
              ? Center(child: Text('No task with this category'))
              : ListView.builder(
                  itemCount: tasksInCategory.length,
                  itemBuilder: (context, index) {
                    final task = tasksInCategory[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(taskDetailScreen, arguments: task);
                      },
                      child: CategoryTaskTile(
                        task: task,
                        isTaskCompleted: task.category == 'Completed',
                      ),
                    );
                  },
                ),
        ));
  }
}
