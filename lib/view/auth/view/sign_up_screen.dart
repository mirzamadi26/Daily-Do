import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/app_strings.dart';
import 'package:daily_do/utils/form_validators.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:daily_do/view/auth/controller/auth_controller.dart';
import 'package:daily_do/widgets/custom_button.dart';
import 'package:daily_do/widgets/custom_textform_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends GetView<AuthController> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKeySignUpScreen,
        body: Obx(() => ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Text(
                        "Daily Do",
                        style: TextStyles.labelStyleText().copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: kGreenColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyles.labelPoppinsTextStyle()
                          .copyWith(fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: controller.signUpScreenFormKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: controller.tecFullName,
                            focusNode: controller.fnFullName,
                            prefixConstraints: BoxConstraints(
                              minWidth: 40,
                            ),
                            validator: FormValidators.validateName,
                            hintText: 'John Doe',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            hintStyle: TextStyles.labelPoppinsTextStyle()
                                .copyWith(fontSize: 14, color: kHintTextColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            controller: controller.tecEmail,
                            focusNode: controller.fnEmail,
                            validator: FormValidators.validateEmail,
                            hintText: 'john@gmail.com',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            hintStyle: TextStyles.labelPoppinsTextStyle()
                                .copyWith(fontSize: 14, color: kHintTextColor),
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            focusNode: controller.fnPassword,
                            controller: controller.tecPassword,
                            hintText: '******',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            hintStyle: TextStyles.labelPoppinsTextStyle()
                                .copyWith(fontSize: 14, color: kHintTextColor),
                            obscureText: controller.isObscure.value,
                            suffix: Obx(() => InkWell(
                                  onTap: () {
                                    controller.togglePasswordVisibility();
                                  },
                                  child: Icon(
                                    controller.isObscure.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: kBlackColor.withOpacity(0.9),
                                    size: 20,
                                  ),
                                )),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            focusNode: controller.fnConfirmPassword,
                            controller: controller.tecConfirmPassword,
                            hintText: '******',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            hintStyle: TextStyles.labelPoppinsTextStyle()
                                .copyWith(fontSize: 14, color: kHintTextColor),
                            obscureText: controller.isObscure.value,
                            suffix: Obx(() => InkWell(
                                  onTap: () {
                                    controller
                                        .toggleConfirmPasswordVisibility();
                                  },
                                  child: Icon(
                                    controller.isConfirmObscure.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: kBlackColor.withOpacity(0.9),
                                    size: 20,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButtonWidget(
                      btnLabel: 'SIGN UP',
                      onTap: () {
                        if (controller.signUpScreenFormKey.currentState!
                            .validate()) {
                          controller.signUp();
                        }
                      },
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Already Have an Account?  ',
                            style: TextStyles.labelPoppinsTextStyle().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kBlackColor)),
                        TextSpan(
                            text: 'SIGN IN',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                              },
                            style: TextStyles.labelPoppinsTextStyle().copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kGreenColor)),
                      ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ))));
  }
}
