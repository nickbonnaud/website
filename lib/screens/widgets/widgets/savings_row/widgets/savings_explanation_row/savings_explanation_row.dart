import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/screens/widgets/widgets/savings_row/widgets/savings_explanation_row/widgets/explanation.dart';

class SavingsExplanationRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const SavingsExplanationRow({required GlobalKey businessListViewKey})
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
              "How Nova Pay reduces your costs",
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Explanation(
                    text: "AI driven security reduces per transaction fees by eliminating fraud.",
                    animationPath: 'lotties/brain.zip',
                    businessListViewKey: _businessListViewKey
                  ),
                ),
                SizedBox(width: 60.w),
                Expanded(
                  child: Explanation(
                    text: "No recurring fees or equipment rental costs.",
                    animationPath: 'lotties/register.zip',
                    businessListViewKey: _businessListViewKey
                  )
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Explanation(
                    text: "No hidden fees or surprise rate changes.",
                    animationPath: 'lotties/invoice.zip',
                    businessListViewKey: _businessListViewKey
                  )
                ),
                SizedBox(width: 60.w),
                Expanded(
                  child: Explanation(
                    text: "Unique payment method reduces third party fees, cutting out the middle man.",
                    animationPath: 'lotties/piggy_bank.zip',
                    businessListViewKey: _businessListViewKey
                  ),
                )
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Explanation(
                    text: "Zero setup or installation costs.",
                    animationPath: 'lotties/free.zip',
                    businessListViewKey: _businessListViewKey
                  )
                ),
                SizedBox(width: 60.w),
                Expanded(
                  child: Explanation(
                    text: "No minimum per transaction amount.",
                    animationPath: 'lotties/coins.zip',
                    businessListViewKey: _businessListViewKey
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}