import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/results_row_parallax_bloc.dart';
import 'widgets/results_image.dart';

class ResultsRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const ResultsRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(top: 80.h, left: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(240, 252, 251, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(),
                  SizedBox(height: 40.h),
                  _saveTimeText(),
                  SizedBox(height: 20.h),
                  _zeroContactText(),
                  SizedBox(height: 20.h),
                  _transactionFeeText()
                ],
              )
            ),
            BlocProvider<ResultsRowParallaxBloc>(
              create: (_) => ResultsRowParallaxBloc(),
              child: ResultsImage(businessListViewKey: _businessListViewKey),
            )
          ],
        )
      ),
    );
  }

  Widget _header() {
    return RichText(
      text: TextSpan(
        text: "Why ",
        style: TextStyle(
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(21, 149, 136, 1)
        ),
        children: [
          TextSpan(
            text: "Nova Pay?",
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

  Widget _saveTimeText() {
    return RichText(
      text: TextSpan(
        text: "No processing or delivering bills, ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "reducing ",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(21, 149, 136, 1)
            ),
          ),
          TextSpan(
            text: "wait times.",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ]
      )
    );
  }

  Widget _zeroContactText() {
    return RichText(
      text: TextSpan(
        text: "Increase satisfaction and safety with ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "zero contact ",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(21, 149, 136, 1)
            ),
          ),
          TextSpan(
            text: "payments.",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ]
      )
    );
  }

  Widget _transactionFeeText() {
    return RichText(
      text: TextSpan(
        text: "Reduce transaction fees with industry level ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "low ",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(21, 149, 136, 1)
            ),
          ),
          TextSpan(
            text: "processing costs.",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]
      )
    );
  }
}