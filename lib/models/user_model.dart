import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserModel {
  String uid = '';
  String username = '';
  String email = '';

  Timestamp createdAt = Timestamp.fromDate(DateTime.now());

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
  }) : createdAt = Timestamp.fromDate(DateTime.now());

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? '',
        username = json['username'] ?? '',
        email = json['email'] ?? '',
        createdAt = json['createdAt'] ?? Timestamp.fromDate(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'createdAt': createdAt,
      'username': username
    };
  }
}
