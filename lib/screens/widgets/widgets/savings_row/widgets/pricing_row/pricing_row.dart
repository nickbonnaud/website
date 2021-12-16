import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/info_column.dart';
import 'widgets/title_column.dart';

class PricingRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const PricingRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(206, 248, 219, .4),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: TitleColumn(businessListViewKey: _businessListViewKey),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: InfoColumn(businessListViewKey: _businessListViewKey)
            ),
          ]
        ),
      ),
    );
  }
}