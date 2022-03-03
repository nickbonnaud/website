import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class TextSizer {

  double fullRowHeader({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 60.sp;
    }
    return 50.sp;
  }

  double fullRowBody({required BuildContext context, bool largeMobileText = false}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return largeMobileText ? 60.sp : 45.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 50.sp;
    }
    return 40.sp;
  }

  double halfRow({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 50.sp;
    }
    return 30.sp;
  }
}