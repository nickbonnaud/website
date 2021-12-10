import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/sales_screen_parallax_bloc.dart';
import 'widgets/sales_screen_image.dart';

class SalesScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const SalesScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(254, 248, 234, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: "Intuitive sales ",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: "tracking.",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(253, 192, 47, 1)
                    )
                  ),
                ]
              ),
            )
          ),
          BlocProvider<SalesScreenParallaxBloc>(
            create: (_) => SalesScreenParallaxBloc(),
            child: SalesScreenImage(businessListViewKey: _businessListViewKey),
          ),
        ],
      ),
    );
  }
}