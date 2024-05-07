import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/colors.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/serviceLocator/service_locator.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/core/widgets/custom_text_field.dart';
import 'package:pricer/core/widgets/error_dialog.dart';
import 'package:pricer/core/widgets/loading.dart';
import 'package:pricer/data/helpers/cache_helper.dart';
import 'package:pricer/data/helpers/navigation_helper.dart';
import 'package:pricer/features/auth/data/entity/user_model.dart';
import 'package:pricer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pricer/features/auth/presentation/pages/login_page.dart';
import 'package:pricer/features/home/presentation/bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    String uid = serviceLocator<CacheHelper>().getData(key: "uid");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          'Profile',
          style: regularTextStyle.copyWith(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserModel userModel = UserModel.fromJson(
                  snapshot.data?.data() as Map<String, dynamic>);
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 10).h,
                      child: BlocConsumer<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                          if (state.status == ProfileStatus.error) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ErrorDialog(
                                    message: state.message ?? '');
                              },
                            );
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<ProfileBloc>(context,
                                      listen: false)
                                  .add(PickFile());
                            },
                            child: Container(
                              width: 200.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                  image: userModel.image == null ||
                                          userModel.image?.isEmpty == true
                                      ? null
                                      : DecorationImage(
                                          image: NetworkImage(
                                              userModel.image ?? ''),
                                          fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                  color: Colors.grey),
                              child: userModel.image == null ||
                                      userModel.image?.isEmpty == true
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            userModel.name ?? '',
                            style: largeTextStyle,
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: CustomTextField(
                                        textEditingController: nameController,
                                        hintText: 'Enter your name',
                                        validation: (p0) {
                                          if (p0 == null || p0.isEmpty) {
                                            return "This field cannot be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                      actions: [
                                        CustomButton(
                                            color: Colors.green,
                                            onPressed: () {
                                              if (nameController
                                                  .text.isNotEmpty) {
                                                UserModel model = userModel;
                                                model.name =
                                                    nameController.text;
                                                BlocProvider.of<ProfileBloc>(
                                                        context,
                                                        listen: false)
                                                    .add(UpdateProfile(
                                                        userModel: userModel));
                                                Navigator.pop(context);
                                              }
                                            },
                                            title: 'Save')
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit, color: Colors.black))
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 35.w,
                            ),
                            Text(
                              userModel.mobile ?? 'Enter mobile number!',
                              style: largeTextStyle,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: CustomTextField(
                                          textEditingController:
                                              mobileController,
                                          hintText: 'Enter your mobile number',
                                          validation: (p0) {
                                            if (p0 == null || p0.isEmpty) {
                                              return "This field cannot be empty";
                                            }
                                            if (p0.length < 11) {
                                              return "Please check the number you entered";
                                            }
                                            return null;
                                          },
                                        ),
                                        actions: [
                                          CustomButton(
                                              color: Colors.green,
                                              onPressed: () {
                                                if (mobileController
                                                    .text.isNotEmpty) {
                                                  UserModel model = userModel;
                                                  model.mobile =
                                                      mobileController.text;
                                                  BlocProvider.of<ProfileBloc>(
                                                          context,
                                                          listen: false)
                                                      .add(UpdateProfile(
                                                          userModel:
                                                              userModel));
                                                  Navigator.pop(context);
                                                }
                                              },
                                              title: 'Save')
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ))
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              userModel.email ?? '',
                              style: largeTextStyle.copyWith(
                                  color: primaryColor),
                            ))),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0).h,
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.status == AuthStatus.loggedOut) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              navigateAndFinish(context, LoginPage());
                            });
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            size: Size(300.w, 40.h),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context,listen: false).add(Logout());
                            },
                            title: "Logout",
                            color: Colors.red,
                            child: Text(
                              'Logout',
                              style: regularTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const LottieWidget(type: LottieType.loading);
            }
          }),
    );
  }
}
