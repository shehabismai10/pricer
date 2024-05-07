import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/core/widgets/error_dialog.dart';
import 'package:pricer/data/helpers/navigation_helper.dart';
import 'package:pricer/features/auth/data/helper/auth_helper.dart';
import 'package:pricer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pricer/features/auth/presentation/pages/login_page.dart';
import 'package:pricer/features/home/presentation/pages/homePage.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../data/helpers/validation_helper.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper=context.watch<AuthHelper>();

    return Scaffold(
        body: Form(
      key: context.watch<AuthHelper>().registerForm,
      child: SingleChildScrollView(
        child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height/2.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.r),
                          bottomLeft: Radius.circular(20.r))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).w,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100.h, bottom: 10.h),
                      child: Text(
                        "Pricer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 140.h),
                      child: Text(
                        "Create account",
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: CustomTextField(fillColor: Colors.white,hintTextColor: primaryColor,
                        textEditingController: context.watch<AuthHelper>().name,
                        hintText: 'Name',
                        validation: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "This field cannot be empty";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: CustomTextField(fillColor: Colors.white,hintTextColor: primaryColor,
                        textEditingController: authHelper.email,
                        hintText: 'Email',
                        validation: (p0) {
                          if (!ValidationHelper.validateEmail(p0)) {
                            return "Please check your email";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: CustomTextField(fillColor: Colors.white,hintTextColor: primaryColor,
                        textEditingController:
                        authHelper.password,
                        visible: true,
                        hintText: 'Password',
                        validation: (p0) {
                          if (!ValidationHelper.validatePassword(p0)) {
                            return "Password length must be more than 6 character";
                          }
                        },
                      ),
                    ),
                    BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                      if (state.status == AuthStatus.loggedIn) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          navigateAndReplace(context, const HomePage());
                        });
                      }
                      if (state.status == AuthStatus.userCreated) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'User created',
                              style:
                                  regularTextStyle.copyWith(color: Colors.white),
                            )));
                      }
                      if (state.status == AuthStatus.error) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialog(message: state.message ?? '');
                          },
                        );
                      }
                    }, builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                        if( state.status != AuthStatus.loading){
                          if (authHelper.registerForm.currentState?.validate() == true) {
                            BlocProvider.of<AuthBloc>(context, listen: false).add(
                                Register(
                                    email: authHelper.email.text,
                                    password:authHelper.password.text,
                                    name: authHelper.name.text));
                          }}
                        },
                        size: Size(150.w, 40.h),
                        title: 'Create account',
                        color: primaryColor,
                        loading: state.status == AuthStatus.loading,
                        child:  state.status == AuthStatus.loading?CircularProgressIndicator():Text(
                          'Create account',
                          style: regularTextStyle.copyWith(color: Colors.white),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0).h,
                      child: Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: regularTextStyle.copyWith(color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(_createRoute());
                              },
                              child: Text(
                                'Login!',
                                style: standardTextStyle.copyWith(
                                    color: primaryColor),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}