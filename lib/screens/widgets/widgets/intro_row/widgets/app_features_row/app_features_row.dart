import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/business_screen/business_screen.dart';
import 'widgets/notification_screen/notification_screen.dart';

class AppFeaturesRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const AppFeaturesRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Row(
        children: [
          Expanded(
            child: BusinessScreen(businessListViewKey: _businessListViewKey)
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: NotificationScreen(businessListViewKey: _businessListViewKey)
          )
        ],
      ),
    );
  }
}