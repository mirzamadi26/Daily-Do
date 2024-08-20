import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_images.dart';
import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/add_task/view/add_task.dart';
import 'package:daily_do/view/drawer/view/drawer.dart';
import 'package:daily_do/view/home/components/categories_widget.dart';
import 'package:daily_do/view/home/components/home_header.dart';
import 'package:daily_do/view/home/components/task_list_tile.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:daily_do/view/home/controller/theme_controller.dart';
import 'package:daily_do/view/home/view/task_category_screen.dart';
import 'package:daily_do/view/home/view/task_details.dart';
import 'package:daily_do/widgets/custom_scaffold.dart';
import 'package:daily_do/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskListScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    controller.getTaskCountByCategory('Work');
    controller.getTaskCountByCategory('Personal');
    controller.getTaskCountByCategory('Shopping');
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        //Drawer
        drawer: CustomDrawer(),
        key: controller.scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              controller: controller,
              themeController: themeController,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Search Field Here
                    CustomTextFormField(
                      focusNode: controller.searchFocus,
                      controller: controller.searchController,
                      onChanged: (va) {
                        controller.searchQuery.value = va;
                        controller.update();
                      },
                      hintText: 'Search Task here...',
                      prefix: Icon(Icons.search),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Show Categories
                    Text(
                      "Categories",
                      style: TextStyles.labelPoppinsTextStyle().copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: kBlackColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      controller.getTaskCountByCategory('Work');
                      controller.getTaskCountByCategory('Personal');
                      controller.getTaskCountByCategory('Shopping');
                      return CategoriesWidget(controller: controller);
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TabBar(
                      dividerHeight: 0,
                      indicatorWeight: 3,
                      indicatorColor: kYellowColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelStyle: TextStyles.appBarTextStyle()
                          .copyWith(
                              color: kHintTextColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                      labelStyle: TextStyles.appBarTextStyle().copyWith(
                          color: kBlackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                      unselectedLabelColor: kHintTextColor,
                      labelColor: kYellowColor,
                      tabs: const [
                        Tab(child: Text("Today")),
                        Tab(child: Text("Upcoming")),
                        Tab(child: Text("Completed")),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          //1st Tab
                          Obx(() {
                            final today = DateFormat('EEE d, MMMM')
                                .format(DateTime.now());
                            final tasksDueToday = controller.tasks
                                .where((task) =>
                                    task.dueDate == today &&
                                    task.status == 'In Progress' &&
                                    task.taskTitle.toLowerCase().contains(
                                        controller.searchQuery.value
                                            .toLowerCase()))
                                .toList();

                            if (tasksDueToday.isEmpty) {
                              return Center(child: Text('No tasks due today'));
                            } else {
                              return ListView.builder(
                                itemCount: tasksDueToday.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final task = tasksDueToday[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(taskDetailScreen,
                                          arguments: task);
                                    },
                                    child: TasksListTile(
                                      task: task,
                                      isTaskCompleted: false,
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                          //2nd Tab
                          Obx(() {
                            final today = DateTime.now();
                            final searchQuery = controller.searchQuery.value
                                .toLowerCase(); // Assuming searchQuery is an observable

                            final tasksUpcoming =
                                controller.tasks.where((task) {
                              try {
                                final dueDateString =
                                    '${task.dueDate}, ${today.year}';
                                final dueDate = DateFormat('EEE d, MMMM, yyyy')
                                    .parse(dueDateString);
                                print('Parsed Due Date: $dueDate');

                                final difference =
                                    dueDate.difference(today).inDays;

                                // Check if the task is due in the future and if the status is "In Progress"
                                bool isUpcoming = difference >= 1 &&
                                    task.status == 'In Progress';

                                // Check if the title matches the search query (case insensitive)
                                bool matchesSearch = task.taskTitle
                                    .toLowerCase()
                                    .contains(searchQuery);

                                return isUpcoming && matchesSearch;
                              } catch (e) {
                                print(
                                    'Error parsing due date for task ${task.taskTitle}: $e');
                                return false;
                              }
                            }).toList();

                            print(
                                'Upcoming tasks count: ${tasksUpcoming.length}');

                            if (tasksUpcoming.isEmpty) {
                              return Center(child: Text('No upcoming tasks'));
                            } else {
                              return ListView.builder(
                                itemCount: tasksUpcoming.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final task = tasksUpcoming[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(taskDetailScreen,
                                          arguments: task);
                                    },
                                    child: TasksListTile(
                                      task: task,
                                      isTaskCompleted: false,
                                    ),
                                  );
                                },
                              );
                            }
                          }),

                          //3rd Tab
                          Obx(() {
                            final tasksDueToday =
                                controller.tasks.where((task) {
                              return task.status == 'Completed' &&
                                  task.taskTitle.toLowerCase().contains(
                                      controller.searchQuery.value
                                          .toLowerCase());
                            }).toList();

                            if (tasksDueToday.isEmpty) {
                              return Center(
                                  child: Text('No task completed yet'));
                            } else {
                              return ListView.builder(
                                itemCount: tasksDueToday.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final task = tasksDueToday[index];
                                  return task.taskTitle.contains(
                                          controller.searchController.text)
                                      ? InkWell(
                                          onTap: () {
                                            Get.toNamed(taskDetailScreen,
                                                arguments: task);
                                          },
                                          child: TasksListTile(
                                            task: task,
                                            isTaskCompleted: true,
                                          ),
                                        )
                                      : SizedBox();
                                },
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              AddTaskScreen(),
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 300),
            );
          },
          child: Icon(
            Icons.add,
          ),
          backgroundColor: kYellowColor,
        ),
      ),
    ));
  }
}
