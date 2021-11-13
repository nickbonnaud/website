import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntegrationText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Integrating Nova Pay",
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          "Seamless setup in a matter of minutes.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Keep your current POS system, Nova Pay works with most major systems.",
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "No initial setup fees or recurring costs.",
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