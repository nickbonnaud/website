import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/integration_row_parallax_bloc.dart';
import 'widgets/integration_image.dart';

class IntegrationRow  extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const IntegrationRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(left: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(241, 246, 250, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(context: context),
                  SizedBox(height: 40.h),
                  _setupText(context: context),
                  SizedBox(height: 20.h),
                  _posText(context: context),
                  SizedBox(height: 20.h),
                  _feesText(context: context)
                ],
              )
            ),
            BlocProvider<IntegrationRowParallaxBloc>(
              create: (_) => IntegrationRowParallaxBloc(),
              child: const IntegrationImage(),
            )
          ],
        ),
      ),
    );
  }

  Widget _header({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Integrating ",
        style: TextStyle(
          fontSize: _headerTextSize(context: context),
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(96, 152, 198, 1)
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

  Widget _setupText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Seamless setup in a matter of ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "minutes.",
            style: TextStyle(
              color: Color.fromRGBO(96, 152, 198, 1)
            ),
          )
        ]
      )
    );
  }

  Widget _posText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Keep your ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: "current ",
            style: TextStyle(
              color: Color.fromRGBO(96, 152, 198, 1)
            )
          ),
          TextSpan(
            text: "POS system, Nova Pay works with most.",
          )
        ]
      )
    );
  }

  Widget _feesText({required BuildContext context}) {
    return RichText(
      text: TextSpan(
        text: "Zero ",
        style: TextStyle(
          fontSize: _bodyTextSize(context: context),
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(96, 152, 198, 1)
        ),
        children: const [
          TextSpan(
            text: "initial setup fees or recurring costs.",
            style: TextStyle(
              color: Colors.black
            )
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