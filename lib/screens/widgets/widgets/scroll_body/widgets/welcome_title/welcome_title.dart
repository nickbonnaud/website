import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import 'widgets/get_started_button/cubit/get_started_button_cubit.dart';
import 'widgets/get_started_button/get_started_button.dart';
import 'widgets/scroll_down/scroll_down.dart';

class WelcomeTitle extends StatelessWidget {

  const WelcomeTitle({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParallaxBloc, ParallaxState>(
      builder: (context, state) {
        return Stack(
          children: [            
            Positioned(
              right: _scrollDownRight(context: context),
              top: 1.25 * state.offset + _scrollDownTop(context: context),
              child: const ScrollDown()
            ),
            Positioned(
              left: 0,
              right: 0,
              top: .5 * state.offset + _textTop(context: context),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to Nova Pay",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _titleTextSize(context: context)
                      ),
                    ),
                    SizedBox(height: 40.h),
                    BlocProvider<GetStartedButtonCubit>(
                      create: (_) => GetStartedButtonCubit(),
                      child: const GetStartedButton(),
                    )
                  ],
                )
              )
            )
          ],
        );
      }
    );
  }

  double _scrollDownTop({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .8.sh;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .55.sh;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return .6.sh;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_DESKTOP')) {
      return .7.sh;
    }
    return .75.sh;
  }

  double _scrollDownRight({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 200.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 100.w;
    } else {
      return 50.w;
    }
  }

  double _textTop({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .4.sh;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .3.sh;
    } else {
      return .25.sh;
    }
  }

  double _titleTextSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 120.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 100.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 80.sp;
    }
    return 80.sp;
  }
}