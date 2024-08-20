import 'package:daily_do/utils/app_colors.dart';
import 'package:daily_do/utils/text_styles.dart';
import 'package:flutter/material.dart';

class RichtextButtonWidget extends StatelessWidget {
  const RichtextButtonWidget(
      {this.text1, this.text2, this.onPressFunction, super.key});

  final Function()? onPressFunction;
  final String? text1, text2;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressFunction,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: "$text1", style: TextStyles.labelInterTextStyle()),
          TextSpan(
              text: "$text2",
              style:
                  TextStyles.labelInterTextStyle().copyWith(color: kGreenColor))
        ]),
      ),
    );
  }
}

class RichtextButtonWidgetS extends StatelessWidget {
  const RichtextButtonWidgetS(
      {this.text1, this.text2, this.onPressFunction, super.key});

  final Function()? onPressFunction;
  final String? text1, text2;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressFunction,
      child: RichText(
         text: TextSpan(children: [
          TextSpan(text: "$text1", style: TextStyles.labelInterTextStyle()),
          TextSpan(
              text: "$text2",
              style:
                  TextStyles.labelInterTextStyle().copyWith(color: kGreenColor))
        ]),
      ),
    );
  }
}
