import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/core/widgets/custom_text_field.dart';
import 'package:pricer/core/widgets/error_dialog.dart';
import 'package:pricer/data/helpers/navigation_helper.dart';
import 'package:pricer/data/helpers/validation_helper.dart';
import 'package:pricer/features/auth/data/helper/auth_helper.dart';
import 'package:pricer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pricer/features/auth/presentation/pages/register_page.dart';
import 'package:pricer/features/home/presentation/pages/homePage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper=context.watch<AuthHelper>();
    return Scaffold(
        body: Form(
      key: authHelper.loginForm,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 250.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15.r),
                        bottomLeft: Radius.circular(15.r))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).w,
              child: SingleChildScrollView(
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
                        "Welcome back",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: CustomTextField(
                        textEditingController: authHelper.email,
                        hintText: 'Email',
                        validation: (p0) {
                          if (!ValidationHelper.validateEmail(p0)) {
                            return "Please check your email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: CustomTextField(
                        textEditingController:
                            authHelper.password,
                        hintText: 'Password',
                        visible: true,
                        validation: (p0) {
                          if (!ValidationHelper.validatePassword(p0)) {
                            return "Password length must be more than 6 character";
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                      if (state.status == LoginStatus.loggedIn) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          navigateAndReplace(context, const HomePage());
                        });
                      }
                      if (state.status == LoginStatus.userCreated) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'User created',
                              style:
                                  regularTextStyle.copyWith(color: Colors.white),
                            )));
                      }
                      if (state.status == LoginStatus.error) {
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
                        if(state.status != LoginStatus.loading){
                          if (Provider.of<AuthHelper>(context,listen: false)
                              .loginForm
                              .currentState
                              ?.validate() ==
                              true) {
                            BlocProvider.of<AuthBloc>(context, listen: false).add(
                                Login(
                                    email: authHelper.email.text,
                                    password: authHelper.password.text));
                          }
                        }
                        },
                        size: Size(150.w, 40.h),
                        title: 'Login',
                        color: Colors.green,
                        loading: state.status == LoginStatus.loading,
                        child:state.status == LoginStatus.loading?const CircularProgressIndicator(): Text(
                          'Login',
                          style: regularTextStyle.copyWith(color: Colors.white),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0).h,
                      child: Row(
                        children: [
                          Text(
                            'New here?',
                            style: regularTextStyle,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateAndReplace(context, const RegisterPage());
                              },
                              child: Text(
                                'Create account!',
                                style: regularTextStyle.copyWith(
                                    color: Colors.deepPurple),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
