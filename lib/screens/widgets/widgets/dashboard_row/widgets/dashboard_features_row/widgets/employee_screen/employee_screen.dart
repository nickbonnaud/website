import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'bloc/employee_screen_parallax_bloc.dart';
import 'widgets/employee_screen_image.dart';

class EmployeeScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const EmployeeScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(225, 250, 248, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocProvider<EmployeeScreenParallaxBloc>(
              create: (_) => EmployeeScreenParallaxBloc(),
              child: EmployeeScreenImage(businessListViewKey: _businessListViewKey),
            )
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Rich ",
                style: TextStyle(
                  fontSize: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
                    ? 50.sp : 30.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color.fromRGBO(21, 149, 136, 1)
                ),
                children: const [
                  TextSpan(
                    text: 'ecosystem of features',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  )
                ]
              )
            )
          )
        ],
      ),
    );
  }
}