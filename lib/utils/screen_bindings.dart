import 'package:daily_do/view/add_task/controller/add_task_controller.dart';
import 'package:daily_do/view/auth/controller/auth_controller.dart';
import 'package:daily_do/view/edit/controller/edit_controller.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:daily_do/view/home/controller/theme_controller.dart';
import 'package:daily_do/view/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => AddTaskController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => EditTaskController());
    Get.lazyPut(() => SplashController());
  }
}
