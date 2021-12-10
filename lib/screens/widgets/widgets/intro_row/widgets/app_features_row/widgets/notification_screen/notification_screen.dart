import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/notification_screen_parallax_bloc.dart';
import 'widgets/notification_screen_image.dart';

class NotificationScreen extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const NotificationScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(36, 79, 122, .3),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: "Save ",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: "time.",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(36, 79, 122, 1)
                    ),
                  )
                ]
              )
            )
          ),
          BlocProvider<NotificationScreenParallaxBloc>(
            create: (_) => NotificationScreenParallaxBloc(),
            child: NotificationScreenImage(businessListViewKey: _businessListViewKey),
          ),
        ],
      ),
    );
  }
}