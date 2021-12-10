import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/dashboard_complement_row/dashboard_complement_row.dart';
import 'widgets/dashboard_features_row/dashboard_features_row.dart';
import 'widgets/dashboard_laptop_row/dashboard_laptop_row.dart';

class DashboardRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const DashboardRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.7),
          spreadRadius: 15,
          blurRadius: 5,
          offset: const Offset(0, 3))
        ]
      ),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          DashboardLaptopRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          DashboardFeaturesRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          DashboardComplementRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h)
        ],
      ),
    );
  }
}