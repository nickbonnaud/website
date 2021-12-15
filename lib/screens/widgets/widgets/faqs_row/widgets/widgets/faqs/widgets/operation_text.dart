import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/cubit/signup_button_cubit.dart';
import 'widgets/signup_button.dart';

class OperationText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Using Nova Pay",
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          "Detects Nova Pay customers and assigns bill automatically.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Optionally, assign a customer's bill to them through your POS.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Bill is closed and paid when the customer leaves your business.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 30.h),
        Align(
          child: BlocProvider<SignupButtonCubit>(
            create: (_) => SignupButtonCubit(),
            child: SignupButton(),
          ) 
        )
      ],
    );
  }
}