import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Why Nova Pay?",
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          "Decrease wait and increase turnover with no need to deliver and process bill.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Increase customer satisfaction and safety with zero contact payments.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Reduce transaction fees with industry level low processing costs.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 30.h),
        Align(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
            ),
            onPressed: () => _goToSignup(), 
            child: Text(
              "Signup Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp
              ),
            )
          ),
        )
      ],
    );
  }

  void _goToSignup() {
    print('go to signup');
  }
}