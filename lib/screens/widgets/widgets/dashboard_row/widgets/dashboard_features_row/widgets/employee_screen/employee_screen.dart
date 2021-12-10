import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/employee_screen_parallax_bloc.dart';
import 'widgets/employee_screen_image.dart';

class EmployeeScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const EmployeeScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(225, 250, 248, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: "Rich ",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color.fromRGBO(21, 149, 136, 1)
                ),
                children: [
                  TextSpan(
                    text: 'ecosystem of features.',
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black
                    ),
                  )
                ]
              )
            )
          ),
          BlocProvider<EmployeeScreenParallaxBloc>(
            create: (_) => EmployeeScreenParallaxBloc(),
            child: EmployeeScreenImage(businessListViewKey: _businessListViewKey),
          )
        ],
      ),
    );
  }
}