import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/text_sizer.dart';

import 'bloc/results_row_parallax_bloc.dart';
import 'widgets/results_image.dart';

class ResultsRow extends StatelessWidget {
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  ResultsRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

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
                child: ResultsImage(businessListViewKey: _businessListViewKey),
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
          fontSize: _textSizer.fullRowHeader(context: context),
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
          fontSize: _textSizer.fullRowBody(context: context, largeMobileText: true),
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
          fontSize: _textSizer.fullRowBody(context: context, largeMobileText: true),
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
          fontSize: _textSizer.fullRowBody(context: context, largeMobileText: true),
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
}