import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/responsive_layout_helper.dart';

import 'widgets/employee_screen/bloc/employee_screen_parallax_bloc.dart';
import 'widgets/employee_screen/employee_screen.dart';
import 'widgets/sales_screen/bloc/sales_screen_parallax_bloc.dart';
import 'widgets/sales_screen/sales_screen.dart';

class DashboardFeaturesRow extends StatelessWidget {
  final ResponsiveLayoutHelper _layoutHelper = const ResponsiveLayoutHelper();

  const DashboardFeaturesRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeScreenParallaxBloc>(
            create: (_) => EmployeeScreenParallaxBloc(),
          ),
          BlocProvider<SalesScreenParallaxBloc>(
            create: (_) => SalesScreenParallaxBloc(),
          )
        ],
        child: ResponsiveRowColumn(
          layout: _layoutHelper.setLayout(context: context, deviceSize: TABLET),
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          rowSpacing: 20.w,
          columnSpacing: 60.h,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              child: EmployeeScreen()
            ),
            const ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              child: SalesScreen()
            )
          ],
        )
      )
    );
  }
}