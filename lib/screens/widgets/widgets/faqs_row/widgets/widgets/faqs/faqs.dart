import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/screens/widgets/widgets/faqs_row/widgets/widgets/faq_tab_bar/cubit/faq_tab_bar_cubit.dart';

import 'widgets/integration_image.dart';
import 'widgets/integration_text.dart';
import 'widgets/operation_image.dart';
import 'widgets/operation_text.dart';
import 'widgets/results_image.dart';
import 'widgets/results_text.dart';

class Faqs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _faqText(context: context)
        ),
        Expanded(
          child: _faqImage(context: context)
        )
      ],
    );
  }

  Widget _faqText({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(right: 50.w),
      child: BlocBuilder<FaqTabBarCubit, int>(
        builder: (context, index) {
          if (index == 0) {
            return IntegrationText();
          } else if (index == 1) {
            return OperationText();
          } else {
            return ResultsText();
          }
        }
      ),
    );
  }

  Widget _faqImage({required BuildContext context}) {
    return BlocBuilder<FaqTabBarCubit, int>(
      builder: (context, index) {
        if (index == 0) {
          return IntegrationImage();
        } else if (index == 1) {
          return OperationImage();
        } else {
          return ResultsImage();
        }
      }
    );
  }
}