import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_do/models/task_model.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyTaskDetails = GlobalKey<ScaffoldState>();
  final titleCont = TextEditingController();
  final dateCont = TextEditingController();
  final timeCont = TextEditingController();

  final descCont = TextEditingController();

  final taskFoc = FocusNode();
  final dateFoc = FocusNode();
  final timeFoc = FocusNode();

  final desFoc = FocusNode();
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;
  var selectedCategory = 0.obs;
  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void selectCategory(int index) {
    selectedCategory.value = index;
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Format the selected date
      String formattedDate = DateFormat('EEE d, MMMM').format(pickedDate);
      // Update the controller and text field
      selectedDate.value = formattedDate;
      dateCont.text = formattedDate;
    }
  }

  void selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat.jm().format(DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute));

      selectedTime.value = formattedTime;
      timeCont.text = formattedTime;
    }
  }

  bool validateInputs() {
    if (titleCont.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a task title');
      return false;
    }
    if (descCont.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a task description');
      return false;
    }
    if (selectedDate.value.isEmpty) {
      Get.snackbar('Error', 'Please select a date');
      return false;
    }
    if (selectedTime.value.isEmpty) {
      Get.snackbar('Error', 'Please select a time');
      return false;
    }
    return true;
  }

  Future<void> uploadTask() async {
    if (validateInputs()) {
      isLoading.value = true;
      String taskId = _firestore.collection('tasks').doc().id;
      TaskModel task = TaskModel(
        taskId: taskId,
        taskTitle: titleCont.text,
        taskDescription: descCont.text,
        dueDate: selectedDate.value,
        time: selectedTime.value,
        userId: auth.currentUser!.uid,
        status: 'In Progress',
        category: selectedCategory.value == 0
            ? "Personal"
            : selectedCategory.value == 1
                ? "Work"
                : "Shopping",
      );
      await _firestore.collection('tasks').doc(task.taskId).set(task.toMap());
      await Get.find<HomeController>().fetchTasks();
      isLoading.value = false;
      titleCont.clear();
      descCont.clear();
      dateCont.clear();
      timeCont.clear();
      Get.back();
      Get.snackbar('Success', 'Task added Successfully');
    }
  }
}
