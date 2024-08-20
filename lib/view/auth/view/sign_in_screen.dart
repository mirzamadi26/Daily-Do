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

class SignInScreen extends GetView<AuthController> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKeySignInScreen,
        body: Obx(() => ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign in",
                    style: TextStyles.labelPoppinsTextStyle()
                        .copyWith(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Form(
                    key: controller.loginScreenFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.username,
                          focusNode: controller.emailFoc,
                          hintText: 'john@gmail.com',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          hintStyle: TextStyles.labelPoppinsTextStyle()
                              .copyWith(fontSize: 14, color: kHintTextColor),
                          validator: FormValidators.validateEmail,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => CustomTextFormField(
                              controller: controller.password,
                              prefixConstraints: BoxConstraints(minWidth: 40),
                              focusNode: controller.passwordFoc,
                              hintText: '******',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              hintStyle: TextStyles.labelPoppinsTextStyle()
                                  .copyWith(
                                      fontSize: 14, color: kHintTextColor),
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
                              validator: FormValidators.validatePassword,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "FORGOT PASSWORD",
                        style: TextStyles.labelPoppinsTextStyle().copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: kGreenColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButtonWidget(
                    btnLabel: 'SIGN IN',
                    onTap: () {
                      if (controller.loginScreenFormKey.currentState!
                          .validate()) {
                        controller.logIn();
                      }
                    },
                  ),
                  Spacer(),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Don\'t Have an Account?  ',
                          style: TextStyles.labelPoppinsTextStyle().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: kBlackColor)),
                      TextSpan(
                          text: 'SIGN UP',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(signUpView);
                            },
                          style: TextStyles.labelPoppinsTextStyle().copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: kGreenColor)),
                    ])),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ))));
  }
}
