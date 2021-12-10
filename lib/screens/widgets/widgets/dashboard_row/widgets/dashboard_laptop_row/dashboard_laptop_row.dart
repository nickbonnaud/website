import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/laptop_parallax_bloc.dart';
import 'widgets/laptop_image.dart';

class DashboardLaptopRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const DashboardLaptopRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(60.w, 80.h, 60.w, 40.h),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 244, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              text: TextSpan(
                text: "Dashboard effortlessly ",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: "syncs ",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(230, 37, 101, 1)
                    )
                  ),
                  TextSpan(
                    text: "with your POS.",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ]
              )
            ),
            BlocProvider<LaptopParallaxBloc>(
              create: (_) => LaptopParallaxBloc(),
              child: LaptopImage(businessListViewKey: _businessListViewKey)
            ),
          ],
        ),
      ),
    );
  }
}