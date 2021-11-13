import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/screens/widgets/widgets/savings_row/widgets/savings_explanation_row/widgets/explanation.dart';

class SavingsExplanationRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const SavingsExplanationRow({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController; 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
        child: Column(
          children: [
            SizedBox(height: 20.h),
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
                    iconData: AnimatedIcons.add_event,
                    businessListViewKey: _businessListViewKey,
                    scrollController: _scrollController
                  ),
                ),
                Expanded(
                  child: Explanation(
                    text: "No recurring fees, setup costs, or equipment rental fees.",
                    iconData: AnimatedIcons.arrow_menu,
                    businessListViewKey: _businessListViewKey,
                    scrollController: _scrollController
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
                    text: "Unique payment processing method reduces third party fees, cutting out the middle man.",
                    iconData: AnimatedIcons.arrow_menu,
                    businessListViewKey: _businessListViewKey,
                    scrollController: _scrollController
                  )
                ),
                Expanded(
                  child: Explanation(
                    text: "No hidden fees or surprise rate changes.",
                    iconData: AnimatedIcons.arrow_menu,
                    businessListViewKey: _businessListViewKey,
                    scrollController: _scrollController
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