import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pricer/core/constants/strings.dart';

class LottieWidget extends StatelessWidget {
  final LottieType type;
  const LottieWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return   Center(child: Padding(
      padding: const EdgeInsets.only(top: 20.0).h,
      child: Lottie.asset(getLottie(type)),
    ),);
  }
}
String getLottie(LottieType type){
  switch(type){
    case LottieType.loading:
     return loadingLottie;
    case LottieType.empty:
return noDataLottie;
case LottieType.searching:
   return searchingLottie;
  }
}
enum LottieType{
  loading,empty,searching
}