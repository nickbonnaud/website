import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/integration_row_parallax_bloc.dart';
import 'widgets/integration_image.dart';

class IntegrationRow  extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const IntegrationRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(left: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(241, 246, 250, 1),
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
                  _setupText(),
                  SizedBox(height: 20.h),
                  _posText(),
                  SizedBox(height: 20.h),
                  _feesText()
                ],
              )
            ),
            BlocProvider<IntegrationRowParallaxBloc>(
              create: (_) => IntegrationRowParallaxBloc(),
              child: IntegrationImage(businessListViewKey: _businessListViewKey),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return RichText(
      text: TextSpan(
        text: "Integrating ",
        style: TextStyle(
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(96, 152, 198, 1)
        ),
        children: const [
          TextSpan(
            text: "Nova Pay",
            style: TextStyle(
              color: Colors.black
            ),
          )
        ]
      )
    );
  }

  Widget _setupText() {
    return RichText(
      text: TextSpan(
        text: "Seamless setup in a matter of ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "minutes.",
            style: TextStyle(
              color: Color.fromRGBO(96, 152, 198, 1)
            ),
          )
        ]
      )
    );
  }

  Widget _posText() {
    return RichText(
      text: TextSpan(
        text: "Keep your ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "current ",
            style: TextStyle(
              color: Color.fromRGBO(96, 152, 198, 1)
            )
          ),
          TextSpan(
            text: "POS system, Nova Pay works with most.",
          )
        ]
      )
    );
  }

  Widget _feesText() {
    return RichText(
      text: TextSpan(
        text: "Zero ",
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(96, 152, 198, 1)
        ),
        children: const [
          TextSpan(
            text: "initial setup fees or recurring costs.",
            style: TextStyle(
              color: Colors.black
            )
          )
        ]
      )
    );
  }
}