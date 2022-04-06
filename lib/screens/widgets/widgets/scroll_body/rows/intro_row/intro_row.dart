import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';

import 'widgets/app_features_row/app_features_row.dart';
import 'widgets/payment_image_row/payment_image_row.dart';
import 'widgets/receipt_row/receipt_row.dart';

class IntroRow extends StatelessWidget {

  const IntroRow({Key? key})
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
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: '/assets/logo.png',
            width: _logoSize(context: context),
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40.h),
          Text(
            "Smarter Payments",
            style: TextStyle(
              fontSize: _titleFontSize(context: context),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Lower Costs",
            style: TextStyle(
              fontSize: _titleFontSize(context: context),
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: .15.sw),
            child: Text(
              "Contactless, AI driven payments keep your business safe and secure. No waiting on bills or checks, decreasing wait time and increasing turnover. Nova works with most major point of sale systems. All at a lower cost than your current POS system.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
                fontSize: _bodyFontSize(context: context)
              ),
              textAlign: TextAlign.center,
            )
          ),
          SizedBox(height: 60.h),
          const PaymentImageRow(),
          SizedBox(height: 60.h),
          const AppFeaturesRow(),
          SizedBox(height: 60.h),
          const ReceiptRow(),
          SizedBox(height: 60.h)
        ],
      )
    );
  }

  double _logoSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .5.sw;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .4.sw;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return .3.sw; 
    }
    return .2.sw;
  }
  
  double _titleFontSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 100.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 90.sp;
    }
    return 80.sp;
  }

  double _bodyFontSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 50.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 30.sp; 
    }
    return 40.sp;
  }
}