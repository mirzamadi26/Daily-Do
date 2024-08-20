import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_do/models/user_model.dart';
import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/view/home/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeySignInScreen = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeySignUpScreen = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> loginScreenFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpScreenFormKey = GlobalKey<FormState>();
  var obscureText = true.obs;
  var obscureText1 = true.obs;
  var checkValue = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final emailFoc = FocusNode();
  final passwordFoc = FocusNode();

  final tecEmail = TextEditingController();
  final tecFullName = TextEditingController();
  final tecPassword = TextEditingController();
  final tecConfirmPassword = TextEditingController();

  final fnEmail = FocusNode();
  final fnPassword = FocusNode();
  final fnFullName = FocusNode();
  final fnConfirmPassword = FocusNode();

  var isObscure = true.obs;
  var isConfirmObscure = true.obs;

  var isSwitched = false.obs;
  var isLoading = false.obs;

  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }

  Future<void> signUp() async {
    UserCredential? userCredentials;
    try {
      isLoading.value = true;
      userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: tecEmail.text, password: tecPassword.text.trim());
    } on FirebaseAuthException catch (e) {
      print('error occured while signing in ${e.message.toString()}');
      isLoading.value = false;
      Get.snackbar('Error', e.message.toString());
    }
    if (userCredentials != null) {
      String uid = userCredentials.user!.uid;

      print('user id $uid');
      UserModel newUser = UserModel(
        uid: uid,
        username: tecFullName.text,
        email: tecEmail.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(newUser.toJson());
      await Get.find<HomeController>().fetchUserData();
      Get.offAllNamed(homeScreen);

      isLoading.value = false;
    }
  }

  Future<void> logIn() async {
    try {
      isLoading.value = true;

      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: username.text, password: password.text);

      if (userCredential.user != null) {
        // Fetch user data from Firestore

        await Get.find<HomeController>().fetchUserData();
        isLoading.value = false;

        Get.offAllNamed(homeScreen);

        Get.snackbar(
          'Success',
          'Logged In Successfully',
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      switch (e.code) {
        case "invalid-email":
          Get.snackbar('Error', 'Invalid Email');
          break;
        case "user-disabled":
          Get.snackbar('Error', 'User Disabled!');
          break;
        case "user-not-found":
          Get.snackbar('Error', 'User Not Found');
          break;
        default:
          Get.snackbar('Error', 'Please Enter Correct Email & Password');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: ${e.toString()}');
    }
  }
}
