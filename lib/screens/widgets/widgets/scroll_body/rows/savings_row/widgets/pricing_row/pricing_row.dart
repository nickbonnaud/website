import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/info_column.dart';
import 'widgets/title_column.dart';

class PricingRow extends StatelessWidget {

  const PricingRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(206, 248, 219, .4),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: const TitleColumn(),
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const InfoColumn()
            ),
          ]
        ),
      ),
    );
  }
}