import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/data/helpers/state_management_helper.dart';
import 'package:pricer/features/auth/presentation/pages/login_page.dart';
import 'package:pricer/features/home/presentation/pages/homePage.dart';
import 'package:pricer/firebase_options.dart';

import 'core/serviceLocator/service_locator.dart';
import 'data/helpers/cache_helper.dart';
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper().init();
 String? uid= serviceLocator<CacheHelper>().getData(key: 'uid');
  runApp( MyApp(starting:uid==null||uid=='null'?LoginPage():HomePage()));
}

class MyApp extends StatelessWidget {
  final Widget starting;
  const MyApp({super.key, required this.starting});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: providerList,
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => MaterialApp(
              title: 'Pricer',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home:   starting),
        ));
  }
}
