import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class TypicalSavingsTitle extends StatelessWidget {
  
  const TypicalSavingsTitle({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      "Typical Savings",
      style: TextStyle(
        fontSize: _savingsTextSize(context: context),
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    );
  }

  double _savingsTextSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 140.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 100.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 80.sp;
    } else {
      return 60.sp;
    }
  }
}