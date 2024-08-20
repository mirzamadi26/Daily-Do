class TaskModel {
  String taskId;
  String userId;
  String taskTitle;
  String taskDescription;
  String dueDate;
  String time;
  String category;
  String status;

  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.dueDate,
    required this.userId,
    required this.time,
    required this.category,
    required this.status,
  });

  // Convert TaskModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskTitle': taskTitle,
      'userId': userId,
      'taskDescription': taskDescription,
      'dueDate': dueDate,
      'time': time,
      'status': status,
      'category': category,
    };
  }

  // Create TaskModel from a Map (JSON)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'],
      userId: json['userId'],
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      dueDate: json['dueDate'],
      time: json['time'],
      status: json['status'],
      category: json['category'],
    );
  }
}
