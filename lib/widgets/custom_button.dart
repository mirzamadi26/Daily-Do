import 'package:daily_do/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../../utils/app_colors.dart';

//ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  String btnLabel = "";
  final double marginBottom;
  final double marginTop;
  final double borderRadius;
  final double height;
  final TextStyle? btnLabelStyle;
  final bool isGradientBg;
  final bool isWhiteBg;
  final Color bgColor;
  final Color? borderColor;
  final bool isBtnDisabled;
  CustomButtonWidget({
    required this.btnLabel,
    this.onTap,
    this.marginBottom = 20,
    this.marginTop = 20,
    this.borderRadius = 8.0,
    this.height = 48.0,
    this.isWhiteBg = false,
    this.bgColor = kPrimaryColor,
    this.isBtnDisabled = false,
    this.btnLabelStyle,
    this.isGradientBg = false,
    this.borderColor = kBlackColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: height,
      margin: EdgeInsets.only(
          left: 0, right: 0, bottom: marginBottom, top: marginTop),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isWhiteBg
              ? Colors.transparent
              : isGradientBg
                  ? null
                  : bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border:
              Border.all(color: isWhiteBg ? borderColor! : Colors.transparent)),
      child: ElevatedButton(
        style: const ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
        onPressed: onTap,
        child: Text(
          btnLabel,
          style: btnLabelStyle ??
              TextStyles.appBarTextStyle().copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: kWhiteColor),
        ),
      ).animate().scale(
            curve: Curves.elasticOut,
            duration: 200.ms,
          ),
    );
  }
}
