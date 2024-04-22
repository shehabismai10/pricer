import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Size? size;
  final Widget? child;
  final Color? color;
  final bool? enabled;
  final bool? loading;
  const CustomButton(
      {super.key,
        required this.onPressed,
        required this.title,
        this.color,
        this.size,
        this.child,
        this.enabled,  this.loading});

  @override
  Widget build(BuildContext context) {
    if (enabled == true || enabled == null) {
      return ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(size),
              backgroundColor: MaterialStateProperty.all(color)),
          onPressed: onPressed,
          child:loading==true?const CircularProgressIndicator(): child ??
              Text(
                title,
                style: standardTextStyle.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w400),
              ));
    } else {
      return const SizedBox.shrink();
    }
  }
}