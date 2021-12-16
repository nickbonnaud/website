import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/business_screen_parallax_bloc.dart';
import 'widgets/business_screen_image.dart';

class BusinessScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const BusinessScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(236, 229, 242, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: "Reach ",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: "new ",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(121, 96, 241, 1)
                    )
                  ),
                  const TextSpan(
                    text: "customers."
                  )
                ]
              ),
            )
          ),
          BlocProvider<BusinessScreenParallaxBloc>(
            create: (_) => BusinessScreenParallaxBloc(),
            child: BusinessScreenImage(businessListViewKey: _businessListViewKey),
          ),
        ],
      ),
    );
  }
}