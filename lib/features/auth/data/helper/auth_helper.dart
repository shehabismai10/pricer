import 'package:flutter/cupertino.dart';

class AuthHelper extends ChangeNotifier{
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  GlobalKey<FormState>registerForm = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}