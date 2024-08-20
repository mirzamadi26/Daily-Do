import 'package:daily_do/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_colors.dart';

//ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    required this.focusNode,
    this.autofocus = false,
    this.onTap,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.borderColor,
    this.fillColor,
    this.filled = true,
    this.inputFormatters,
    this.validator,
    this.isViewMode = false,
    this.onChanged,
  });

  final Alignment? alignment;

  final double? width;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode focusNode;

  final bool? autofocus;
  final void Function()? onTap;
  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final bool isViewMode;
  List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: TextFormField(
          readOnly: isViewMode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          focusNode: focusNode,
          cursorColor: kGreenColor,
          onTap: onTap,
          style: textStyle ??
              TextStyles.labelTextStyle().copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kBlackColor),
          obscureText: obscureText!,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          onChanged: onChanged,
          validator: validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            TextStyles.labelTextStyle().copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: kHintTextColor),
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 10,
              right: 2,
              bottom: 10,
            ),
        fillColor: fillColor ?? kBlackColor,
        // filled: filled,
        // border: InputBorder.none,
        border: borderDecoration ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? kFieldBorderColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? kFieldBorderColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor ?? kFieldBorderColor,
                width: 1.5,
              ),
            ),
      );
}
