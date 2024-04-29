import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/core/widgets/custom_text_field.dart';
import 'package:pricer/data/helpers/validation_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Pricer',
          style: regularTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(width: 200.w,
                  textEditingController: search,
                  hintText: 'ex: ps5',
                  validation: (p0) {
                    if (p0 == null || p0.isNotEmpty) {
                      return 'please enter search value';
                    }
                  },
                ),
                CustomButton(color: Colors.deepPurple,size: Size(90.w, 30.h),
                  onPressed: () {},
                  title: 'Search',
                  child: Text(
                    'Search',
                    style: regularTextStyle.copyWith(color: Colors.white,fontSize: 13.sp),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
