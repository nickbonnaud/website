import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/screens/widgets/widgets/intro_row/widgets/receipt_row/receipt_row.dart';

import 'widgets/app_features_row/app_features_row.dart';
import 'widgets/payment_image_row/payment_image_row.dart';

class IntroRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const IntroRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;
  
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
          Image(
            image: const AssetImage('assets/logo.png'),
            width: .2.sw,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40.h),
          Text(
            "Smarter Payments",
            style: TextStyle(
              fontSize: 80.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Lower Costs",
            style: TextStyle(
              fontSize: 80.sp,
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
                fontSize: 40.sp
              ),
              textAlign: TextAlign.center,
            )
          ),
          SizedBox(height: 150.h),
          PaymentImageRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          AppFeaturesRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          ReceiptRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h)
        ],
      )
    );
  }
}