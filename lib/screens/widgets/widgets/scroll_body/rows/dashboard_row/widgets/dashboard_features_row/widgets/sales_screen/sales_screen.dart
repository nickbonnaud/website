import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/helpers/text_sizer.dart';

import 'widgets/sales_screen_image.dart';

class SalesScreen extends StatelessWidget {
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  SalesScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(254, 248, 234, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Intuitive sales ",
                style: TextStyle(
                  fontSize: _textSizer.halfRow(context: context),
                  fontWeight: FontWeight.w800,
                ),
                children: const [
                  TextSpan(
                    text: "tracking",
                    style: TextStyle(
                      color: Color.fromRGBO(253, 192, 47, 1)
                    )
                  ),
                ]
              ),
            )
          ),
          Expanded(
            child: SalesScreenImage(businessListViewKey: _businessListViewKey),
          )
        ],
      ),
    );
  }
}