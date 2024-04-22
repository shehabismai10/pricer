 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final TextEditingController textEditingController;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? isNumber;
  final bool? visible;
  final bool? enabled;
  final Color? fillColor;
  final Color? hintTextColor;
  final double? radius;
  final String? Function(String?) validation;
  final double? width;
  final double? height;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final Function(String)? onTapOutside;
  final int? maxLines;
  final int? maxLength;
  final bool? focus;
  final bool? calc;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.maxLength,
    this.enabled,
    this.suffix,
    this.radius,
    this.isNumber,
    this.fillColor,
    this.hintTextColor,
    this.visible,
    required this.validation,
    this.prefix,
    this.title,
    this.width,
    this.onSubmit,
    this.onChanged,
    this.maxLines = 1,
    this.height,
    this.onTapOutside,
    this.calc,
    this.focus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title ?? "",
              style: smallTextStyle.copyWith(color: primaryColor)),
        SizedBox(
          width: width?.w ?? 350.w,
          child: TextFormField(
            maxLength: maxLength,
            autofocus: focus == true,
            textAlign: calc == true ? TextAlign.center : TextAlign.start,
            validator: validation,
            style: calc == true
                ? largeTextStyle.copyWith(
                color:
                fillColor == primaryColor ? Colors.white : Colors.black)
                : null,
            enabled: enabled ?? false,
            keyboardType:
            isNumber != null && isNumber! ? TextInputType.number : null,
            obscureText: visible ?? false,
            controller: textEditingController,
            onFieldSubmitted: onSubmit,
            onTap: () => onTapOutside,
            onChanged: onChanged,
            maxLines: maxLines,
            expands: false,
            decoration: InputDecoration(
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.red, fontSize: 14.sp),
                errorMaxLines: 1,
                contentPadding:
                EdgeInsets.only(right: 3.w, bottom: 2.h, top: 2.h),
                iconColor: hintColor,
                suffixIcon: suffix,
                counterStyle: const TextStyle(
                  height: double.minPositive,
                ),
                counter: const Offstage(),
                prefixIcon: prefix,
                filled: fillColor != null,
                fillColor: fillColor ?? greyColor.withOpacity(.1),
                labelText: hintText,
                hintStyle: smallTextStyle.copyWith(
                    color: calc == true
                        ? Colors.white
                        : hintTextColor ?? hintColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 10).r,
                    borderSide: BorderSide(
                        color: fillColor ?? Colors.grey.withOpacity(.2))),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 10).r,
                    borderSide: BorderSide(
                        color: fillColor ?? Colors.grey.withOpacity(.2))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 10).r,
                    borderSide: BorderSide(
                        color: fillColor ?? Colors.grey.withOpacity(.2)))),
          ),
        ),
      ],
    );
  }
}