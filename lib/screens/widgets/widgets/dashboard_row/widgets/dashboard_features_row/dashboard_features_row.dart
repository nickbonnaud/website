import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/helpers/responsive_layout_helper.dart';

import 'widgets/employee_screen/employee_screen.dart';
import 'widgets/sales_screen/sales_screen.dart';

class DashboardFeaturesRow extends StatelessWidget {
  final ResponsiveLayoutHelper _layoutHelper = ResponsiveLayoutHelper();
  final GlobalKey _businessListViewKey;

  DashboardFeaturesRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: ResponsiveRowColumn(
        layout: _layoutHelper.setLayout(context: context, deviceSize: TABLET),
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        rowSpacing: 20.w,
        columnSpacing: 60.h,
        children: [
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            child: EmployeeScreen(businessListViewKey: _businessListViewKey)
          ),
          ResponsiveRowColumnItem(
            rowFit: FlexFit.tight,
            child: SalesScreen(businessListViewKey: _businessListViewKey)
          )
        ],
      )
    );
  }
}