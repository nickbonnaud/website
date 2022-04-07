import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/results_row_parallax_bloc.dart';
import 'widgets/results_image.dart';

class ResultsRow extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const ResultsRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(right: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(240, 252, 251, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: BlocProvider<ResultsRowParallaxBloc>(
                create: (_) => ResultsRowParallaxBloc(),
                child: const ResultsImage(),
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(context: context),
                  SizedBox(height: 40.h),
                  _saveTimeText(context: context),
                  SizedBox(height: 20.h),
                  _zeroContactText(context: context),
                  SizedBox(height: 20.h),
                  _transactionFeeText(context: context)
                ],
              )
            ),
          ],
        )
      ),
    );
  }

  Widget _header({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Why ",
        style: TextStyle(
          fontSize: _headerTextSize(context: context),
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(21, 149, 136, 1)
        ),
        children: const [
          TextSpan(
            text: "Nova Pay?",
            style: TextStyle(
              color: Colors.black
            ),
          )
        ]
      )
    );
  }

  Widget _saveTimeText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "No processing or delivering bills, ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "reducing ",
            style: TextStyle(
              color: Color.fromRGBO(21, 149, 136, 1)
            ),
          ),
          TextSpan(
            text: "wait times.",
          )
        ]
      )
    );
  }

  Widget _zeroContactText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Increase satisfaction and safety with ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "zero contact ",
            style: TextStyle(
              color: Color.fromRGBO(21, 149, 136, 1)
            ),
          ),
          TextSpan(
            text: "payments.",
          )
        ]
      )
    );
  }

  Widget _transactionFeeText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Reduce transaction fees with industry level ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "low ",
            style: TextStyle(
              color: Color.fromRGBO(21, 149, 136, 1)
            ),
          ),
          TextSpan(
            text: "processing costs.",
          ),
        ]
      )
    );
  }

  double _headerTextSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 50.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 45.sp;
    }
    return 50.sp;
  }

  double _bodyTextSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 45.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 35.sp;
    }
    return 40.sp;
  }
}