import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/dashboard_complement_row/dashboard_complement_row.dart';
import 'widgets/dashboard_features_row/dashboard_features_row.dart';
import 'widgets/dashboard_laptop_row/dashboard_laptop_row.dart';
import 'widgets/register_button/cubit/register_button_cubit.dart';
import 'widgets/register_button/register_button.dart';

class DashboardRow extends StatelessWidget {

  const DashboardRow({Key? key})
    : super(key: key);

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
          const DashboardLaptopRow(),
          SizedBox(height: 60.h),
          const DashboardFeaturesRow(),
          SizedBox(height: 15.h),
          BlocProvider<RegisterButtonCubit>(
            create: (_) => RegisterButtonCubit(),
            child: const RegisterButton()
          ),
          SizedBox(height: 15.h),
          const DashboardComplementRow(),
          SizedBox(height: 60.h)
        ],
      ),
    );
  }
}