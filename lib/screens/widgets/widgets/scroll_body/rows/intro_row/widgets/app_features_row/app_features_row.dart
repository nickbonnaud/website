import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/helpers/responsive_layout_helper.dart';

import 'widgets/business_screen/bloc/business_screen_parallax_bloc.dart';
import 'widgets/business_screen/business_screen.dart';
import 'widgets/notification_screen/bloc/notification_screen_parallax_bloc.dart';
import 'widgets/notification_screen/notification_screen.dart';

class AppFeaturesRow extends StatelessWidget {
  final ResponsiveLayoutHelper _layoutHelper = ResponsiveLayoutHelper();
  final GlobalKey _businessListViewKey;

  AppFeaturesRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BusinessScreenParallaxBloc>(
            create: (_) => BusinessScreenParallaxBloc(),
          ),
          BlocProvider<NotificationScreenParallaxBloc>(
            create: (_) => NotificationScreenParallaxBloc(),
          ),
        ],
        child: ResponsiveRowColumn(
          layout: _layoutHelper.setLayout(context: context, deviceSize: TABLET),
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          rowSpacing: 20.w,
          columnSpacing: 60.h,
          children: [
            ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              child: BusinessScreen(businessListViewKey: _businessListViewKey)
            ),
            ResponsiveRowColumnItem(
              rowFit: FlexFit.tight,
              child: NotificationScreen(businessListViewKey: _businessListViewKey)
            )
          ],
        )
      )
    );
  }
}