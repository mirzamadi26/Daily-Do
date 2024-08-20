import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_do/models/task_model.dart';
import 'package:daily_do/models/user_model.dart';
import 'package:daily_do/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyTaskDetails = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();
  RxString searchQuery = ''.obs;
  var quote = ''.obs;

  Rx<UserModel?> loggedInUser = Rx<UserModel?>(null);
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchTasks();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      update();
    });
  }

  void fetchQuote() async {
    try {
      isLoading(true);
      final fetchedQuote = await _apiService.fetchQuote();
      quote(fetchedQuote);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch quote');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get();
        if (snapshot.exists) {
          UserModel user = UserModel.fromJson(snapshot.data()!);
          loggedInUser.value = user;
          print('printing inside home===========${loggedInUser.value}');
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchTasks() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      Get.snackbar('Error', 'User is not logged in');
      return;
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: userId) // Filter by userId
          .get();

      List<TaskModel> fetchedTasks = snapshot.docs.map((doc) {
        return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      tasks.assignAll(fetchedTasks);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tasks: $e');
    }
  }

  Future<void> updateTaskStatusToCompleted(String taskId) async {
    isLoading.value = true;
    try {
      DocumentReference taskRef =
          FirebaseFirestore.instance.collection('tasks').doc(taskId);

      await taskRef.update({
        'status': 'Completed',
      });
      await fetchTasks();

      isLoading.value = false;
      Get.close(1);
      Get.snackbar('Success', 'Task marked as Completed');
      print('Task status updated to Completed for taskId: $taskId');
    } catch (e) {
      print('Failed to update task status: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      DocumentReference taskRef =
          FirebaseFirestore.instance.collection('tasks').doc(taskId);
      await taskRef.delete();
      await fetchTasks();

      isLoading.value = false;
      Get.close(1);
      Get.snackbar('Success', 'Task Deleted Successfully');
      print('Task deleted successfully for taskId: $taskId');
    } catch (e) {
      print('Failed to delete task: $e');
      // Handle the error appropriately, like showing a message to the user
    }
  }
    int getTaskCountByCategory(String category) {
    return tasks.where((task) => task.category == category).length;
  }
}
