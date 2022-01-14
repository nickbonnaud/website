import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/helpers/responsive_layout_helper.dart';
import 'package:website/resources/helpers/text_sizer.dart';

import 'widgets/explanation.dart';

class SavingsExplanationRow extends StatelessWidget {
  final ResponsiveLayoutHelper _layoutHelper = ResponsiveLayoutHelper();
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  SavingsExplanationRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey; 
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: [
            Text(
              "How Nova Pay reduces costs",
              style: TextStyle(
                fontSize: _textSizer.fullRowHeader(context: context),
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30.h),
            _responsiveLayout(
              context: context,
              firstWidget: Explanation(
                text: "AI driven security reduces per transaction fees by eliminating fraud.",
                animationPath: 'lotties/brain.zip',
                businessListViewKey: _businessListViewKey
              ),
              secondWidget: Explanation(
                text: "No recurring fees or equipment rental costs.",
                animationPath: 'lotties/register.zip',
                businessListViewKey: _businessListViewKey
              )
            ),
            SizedBox(height: 30.h),
            _responsiveLayout(
              context: context,
              firstWidget: Explanation(
                text: "No hidden fees or surprise rate changes.",
                animationPath: 'lotties/invoice.zip',
                businessListViewKey: _businessListViewKey
              ),
              secondWidget: Explanation(
                text: "Payment method reduces third party fees, cutting out the middle man.",
                animationPath: 'lotties/piggy_bank.zip',
                businessListViewKey: _businessListViewKey
              )
            ),
            SizedBox(height: 30.h),
            _responsiveLayout(
              context: context,
              firstWidget: Explanation(
                text: "Zero setup or installation costs.",
                animationPath: 'lotties/free.zip',
                businessListViewKey: _businessListViewKey
              ),
              secondWidget: Explanation(
                text: "No minimum per transaction amount.",
                animationPath: 'lotties/coins.zip',
                businessListViewKey: _businessListViewKey
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _responsiveLayout({required BuildContext context, required Widget firstWidget, required Widget secondWidget}) {
    return ResponsiveRowColumn(
      layout: _layoutHelper.setLayout(context: context, deviceSize: TABLET),
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      columnCrossAxisAlignment: CrossAxisAlignment.center,
      columnSpacing: 30.h,
      rowSpacing: 60.w,
      children: [
        ResponsiveRowColumnItem(
          rowFit: FlexFit.tight,
          child: firstWidget
        ),
        ResponsiveRowColumnItem(
          rowFit: FlexFit.tight,
          child: secondWidget
        )
      ],
    );
  }
}