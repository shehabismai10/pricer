import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pricer/core/constants/colors.dart';
import 'package:pricer/core/constants/enums.dart';
import 'package:pricer/core/constants/styles.dart';
import 'package:pricer/core/widgets/custom_button.dart';
import 'package:pricer/core/widgets/custom_text_field.dart';
import 'package:pricer/core/widgets/error_dialog.dart';
import 'package:pricer/core/widgets/loading.dart';
import 'package:pricer/features/products/presentation/bloc/products_bloc.dart';
import 'package:pricer/features/products/presentation/widgets/products_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Pricer',
            style: regularTextStyle.copyWith(color: Colors.white),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(
                text: 'Amazon',
              ),
              Tab(
                text: 'Noon',
              ),
              Tab(
                text: 'B-tech',
              ),
              Tab(
                text: 'Used',
              ),
            ],
            labelStyle: regularTextStyle.copyWith(
                fontWeight: FontWeight.w500, color: Colors.white),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listener: (context, state) {
              if (state.status == ProductStatus.error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ErrorDialog(message: state.message ?? '');
                    },
                  );
                });
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          width: 200.w,
                          textEditingController: search,
                          hintText: 'ex: ps5',
                          validation: (p0) {
                            if (p0 == null || p0.isNotEmpty) {
                              return 'please enter search value';
                            }
                          },
                        ),

                        CustomButton(
                          color: Colors.deepPurple,
                          size: Size(90.w, 30.h),
                          onPressed: () {
                            if (state.status != ProductStatus.loading) {
                              if (search.text.isNotEmpty) {
                                BlocProvider.of<ProductsBloc>(context,
                                        listen: false)
                                    .add(GetProducts(query: search.text));
                              }
                            }
                          },
                          title: 'Search',
                          child: Text(
                            'Search',
                            style: regularTextStyle.copyWith(
                                color: Colors.white, fontSize: 13.sp),
                          ),
                        )
                      ],
                    ),
                    state.status == ProductStatus.loading
                        ? const LottieWidget(type: LottieType.loading)
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                border: Border.all(color: primaryColor)),
                            height: MediaQuery.of(context).size.height - 100,
                            child: const TabBarView(children: [
                              ProductsList(types: SiteTypes.amazon),
                              ProductsList(types: SiteTypes.noon),
                              ProductsList(types: SiteTypes.dubizzle),
                              ProductsList(types: SiteTypes.btech),
                            ]),
                          )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
