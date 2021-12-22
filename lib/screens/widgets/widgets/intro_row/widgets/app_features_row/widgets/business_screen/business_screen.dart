import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'bloc/business_screen_parallax_bloc.dart';
import 'widgets/business_screen_image.dart';

class BusinessScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const BusinessScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(236, 229, 242, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocProvider<BusinessScreenParallaxBloc>(
              create: (_) => BusinessScreenParallaxBloc(),
              child: BusinessScreenImage(businessListViewKey: _businessListViewKey),
            )
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Reach ",
                style: TextStyle(
                  fontSize: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
                    ? 50.sp : 30.sp,
                  fontWeight: FontWeight.w800,
                ),
                children: const [
                  TextSpan(
                    text: "new ",
                    style: TextStyle(
                      color: Color.fromRGBO(121, 96, 241, 1)
                    )
                  ),
                  TextSpan(
                    text: "customers",
                    style: TextStyle(
                    ),
                  )
                ]
              ),
            )
          ),
        ],
      ),
    );
  }
}