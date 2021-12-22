import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'bloc/notification_screen_parallax_bloc.dart';
import 'widgets/notification_screen_image.dart';

class NotificationScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const NotificationScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(214, 228, 242, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Save ",
                style: TextStyle(
                  fontSize: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
                    ? 50.sp : 30.sp,
                  fontWeight: FontWeight.w800,
                ),
                children: const [
                  TextSpan(
                    text: "time.",
                    style: TextStyle(
                      color: Color.fromRGBO(36, 79, 122, 1)
                    ),
                  )
                ]
              )
            )
          ),
          Expanded(
            child: BlocProvider<NotificationScreenParallaxBloc>(
              create: (_) => NotificationScreenParallaxBloc(),
              child: NotificationScreenImage(businessListViewKey: _businessListViewKey),
            ),
          )
        ],
      ),
    );
  }
}