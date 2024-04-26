import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/core/widgets/custom_text_field.dart';
import 'package:pricer/core/widgets/error_dialog.dart';
import 'package:pricer/data/helpers/navigation_helper.dart';
import 'package:pricer/data/helpers/validation_helper.dart';
import 'package:pricer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pricer/features/home/presentation/homePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
        body: Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 30.0.h),
            child: CustomTextField(
              textEditingController: email,
              hintText: 'Email',
              validation: (p0) {
                if (ValidationHelper.validateEmail(p0)) {
                  return "Please check your email";
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0.h),
            child: CustomTextField(
              textEditingController: password,
              hintText: 'Password',
              validation: (p0) {
                if (ValidationHelper.validatePassword(p0)) {
                  return "Password length must be more than 6 character";
                }
              },
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if(state is LoggedIn){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigateAndReplace(context, const HomePage());
              });
            }
            if (state is UserCreated) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,
                  content: Text(
                'User created',
                style: regularTextStyle.copyWith(color: Colors.white),
              )));
            }
            if (state is AuthError) {
              showDialog(
                context: context,
                builder: (context) {
                  return ErrorDialog(message: state.message);
                },
              );
            }
          }, builder: (context, state) {
            return CustomButton(
              onPressed: () {},
              title: 'Login',
              color: Colors.green,loading: state is AuthLoading,
              child: Text(
                'Login',
                style: regularTextStyle,
              ),
            );
          })
        ],
      ),
    ));
  }
}
