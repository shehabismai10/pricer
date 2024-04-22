import 'package:flutter/material.dart';

navigateTo(context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => screen,
  ));
}

navigateAndReplace(context, Widget screen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => screen,
  ));
}

navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      maintainState: false,
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
}