import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/employee_screen/employee_screen.dart';
import 'widgets/sales_screen/sales_screen.dart';

class DashboardFeaturesRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const DashboardFeaturesRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Row(
        children: [
          Expanded(
            child: EmployeeScreen(businessListViewKey: _businessListViewKey)
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: SalesScreen(businessListViewKey: _businessListViewKey)
          )
        ],
      ),
    );
  }
}