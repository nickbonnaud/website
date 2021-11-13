import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/faq_tab_bar/faq_tab_bar.dart';
import 'widgets/faqs/faqs.dart';

class FaqRowBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25.h),
        FaqTabBar(),
        SizedBox(height: 25.h),
        Faqs()
      ],
    );
  }
}