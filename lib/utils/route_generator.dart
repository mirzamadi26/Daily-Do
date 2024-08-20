import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/utils/screen_bindings.dart';
import 'package:daily_do/view/add_task/view/add_task.dart';
import 'package:daily_do/view/auth/view/sign_in_screen.dart';
import 'package:daily_do/view/auth/view/sign_up_screen.dart';
import 'package:daily_do/view/home/view/task_details.dart';
import 'package:daily_do/view/home/view/task_home.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: homeScreen,
          page: () => TaskListScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: addTaskScreen,
          page: () => AddTaskScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: taskDetailScreen,
          page: () => TaskDetailsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: signInView,
          page: () => SignInScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: signUpView,
          page: () => SignUpScreen(),
          binding: ScreenBindings()),
    ];
  }
}
