import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/responsive_layout_helper.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/savings_explanation_bloc.dart';
import 'widgets/explanation.dart';

class SavingsExplanationRow extends StatelessWidget {
  final ResponsiveLayoutHelper _layoutHelper = const ResponsiveLayoutHelper();
  final TextSizer _textSizer = const TextSizer();

  const SavingsExplanationRow({Key? key})
    : super(key: key);
  
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
                fontSize: _textSize(context: context),
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30.h),
            _responsiveLayout(
              context: context,
              firstWidget: const Explanation(
                text: "AI driven security reduces per transaction fees by eliminating fraud.",
                animationPath: SavingsExplanationBloc.brainAnimation,
              ),
              secondWidget: const Explanation(
                text: "No recurring fees or equipment rental costs.",
                animationPath: SavingsExplanationBloc.registerAnimation,
              )
            ),
            SizedBox(height: 30.h),
            _responsiveLayout(
              context: context,
              firstWidget: const Explanation(
                text: "No hidden fees or surprise rate changes.",
                animationPath: SavingsExplanationBloc.invoiceAnimation,
              ),
              secondWidget: const Explanation(
                text: "Payment method reduces third party fees, cutting out the middle man.",
                animationPath: SavingsExplanationBloc.piggyBankAnimation,
              )
            ),
            SizedBox(height: 30.h),
            _responsiveLayout(
              context: context,
              firstWidget: const Explanation(
                text: "Zero setup or installation costs.",
                animationPath: SavingsExplanationBloc.freeAnimation,
              ),
              secondWidget: const Explanation(
                text: "No minimum per transaction amount.",
                animationPath: SavingsExplanationBloc.coinsAnimation,
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

  double _textSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 60.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 45.sp;
    }
    return 50.sp;
  }
}