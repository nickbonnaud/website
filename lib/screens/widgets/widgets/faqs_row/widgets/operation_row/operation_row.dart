import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/operation_row_parallax_bloc.dart';
import 'widgets/operation_image.dart';

class OperationRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const OperationRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(top: 80.h, right: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 244, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocProvider<OperationRowParallaxBloc>(
              create: (_) => OperationRowParallaxBloc(),
              child: OperationImage(businessListViewKey: _businessListViewKey),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(),
                  SizedBox(height: 40.h),
                  _assignmentText(),
                  SizedBox(height: 20.h),
                  _optionalText(),
                  SizedBox(height: 20.h),
                  _billClosedText()
                ],
              )
            )
          ],
        )
      ),
    );
  }

  Widget _header() {
    return RichText(
      text: TextSpan(
        text: "Using ",
        style: TextStyle(
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(230, 37, 101, 1)
        ),
        children: [
          TextSpan(
            text: "Nova Pay",
            style: TextStyle(
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          )
        ]
      )
    );
  }

  Widget _assignmentText() {
    return RichText(
      text: TextSpan(
        text: "Detects customers and assigns bill ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "automatically.",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(230, 37, 101, 1)
            ),
          )
        ]
      )
    );
  }

  Widget _optionalText() {
    return RichText(
      text: TextSpan(
        text: "Optionally, ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "assign ",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(230, 37, 101, 1)
            ), 
          ),
          TextSpan(
            text: "a bill through your POS.",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ]
      )
    );
  }

  Widget _billClosedText() {
    return RichText(
      text: TextSpan(
        text: "Bill is closed and paid when the customer ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "leaves ",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(230, 37, 101, 1)
            ), 
          ),
          TextSpan(
            text: "your business.",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ]
      )
    );
  }
}