import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/operation_row_parallax_bloc.dart';
import 'widgets/operation_image.dart';

class OperationRow extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const OperationRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(40.w, 40.h, 60.w, 0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 244, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context: context),
            SizedBox(height: 40.h),
            _assignmentText(context: context),
            SizedBox(height: 20.h),
            _optionalText(context: context),
            SizedBox(height: 20.h),
            _billClosedText(context: context),
            Align(
              alignment: Alignment.center,
              child: BlocProvider<OperationRowParallaxBloc>(
                create: (_) => OperationRowParallaxBloc(),
                child: const OperationImage(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Using ",
        style: TextStyle(
          fontSize: _headerTextSize(context: context),
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(230, 37, 101, 1)
        ),
        children: const [
          TextSpan(
            text: "Nova Pay",
            style: TextStyle(
              color: Colors.black
            ),
          )
        ]
      )
    );
  }

  Widget _assignmentText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Detects customers and assigns bill ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "automatically.",
            style: TextStyle(
              color: Color.fromRGBO(230, 37, 101, 1)
            ),
          )
        ]
      )
    );
  }

  Widget _optionalText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Optionally, ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "assign ",
            style: TextStyle(
              color: Color.fromRGBO(230, 37, 101, 1)
            ), 
          ),
          TextSpan(
            text: "a bill through your POS.",
          )
        ]
      )
    );
  }

  Widget _billClosedText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Bill is closed and paid when the customer ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "leaves ",
            style: TextStyle(
              color: Color.fromRGBO(230, 37, 101, 1)
            ), 
          ),
          TextSpan(
            text: "your business.",
          )
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