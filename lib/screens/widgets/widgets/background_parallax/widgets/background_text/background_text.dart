import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../bloc/background_parallax_bloc.dart';
import 'bloc/background_text_bloc.dart';
import 'widgets/typical_savings_number/bloc/typical_savings_number_bloc.dart';
import 'widgets/typical_savings_number/typical_savings_number.dart';
import 'widgets/typical_savings_title/typical_savings_title.dart';

class BackgroundText extends StatelessWidget {
  
  const BackgroundText({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackgroundTextBloc, BackgroundTextState>(
      builder: (context, state) {
        if (state.currentImage == BackgroundParallaxBloc.secondImage) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: _savingsTitleTop(context: context, state: state).h,
                child: const Align(
                  alignment: Alignment.center,
                  child: TypicalSavingsTitle(),
                )
              ),
              Positioned(
                left: 0,
                right: 0,
                top: _savingsNumberTop(context: context, state: state).h,
                child: Align(
                  alignment: Alignment.center,
                  child: BlocProvider<TypicalSavingsNumberBloc>(
                    create: (_) => TypicalSavingsNumberBloc(),
                    child: const TypicalSavingsNumber(),
                  )
                )
              ),
            ],
          );
        } else if (state.currentImage == BackgroundParallaxBloc.thirdImage) {
          return Positioned(
            left: 0,
            right: 0,
            top: _solutionTextTop(context: context, state: state),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "An all in one solution",
                style: TextStyle(
                  fontSize: _textSize(context: context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              )
            )
          );
        } else if (state.currentImage == BackgroundParallaxBloc.fourthImage) {
          return Positioned(
            left: 0,
            right: 0,
            top: _getStartedTextTop(context: context, state: state),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Ready to get started?",
                style: TextStyle(
                  fontSize: _textSize(context: context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )
            )
          );
        } else {
          return Container();
        }
      }
    );
  }

  double _savingsTitleTop({required BuildContext context, required BackgroundTextState state}) {
    double initialPosition = MediaQuery.of(context).size.height / 2;

    if (state.previousImage == BackgroundParallaxBloc.firstImage) {
      return (initialPosition - state.percentDistance * initialPosition) - 100;
    }
    return (initialPosition - state.percentDistance * initialPosition) - 400;
  }

  double _savingsNumberTop({required BuildContext context, required BackgroundTextState state}) {
    return _savingsTitleTop(context: context, state: state) + 150;
  }

  double _solutionTextTop({required BuildContext context, required BackgroundTextState state}) {
    double initialPosition = MediaQuery.of(context).size.height / 1.5;

    if (state.previousImage == BackgroundParallaxBloc.secondImage) {
      return initialPosition - state.percentDistance * initialPosition;
    }
    return (initialPosition - state.percentDistance * initialPosition) - 400;
  }

  double _getStartedTextTop({required BuildContext context, required BackgroundTextState state}) {
    double initialPosition = MediaQuery.of(context).size.height / 1.5;

    if (state.previousImage == BackgroundParallaxBloc.thirdImage) {
      return initialPosition - state.percentDistance * initialPosition;
    }
    return (initialPosition - state.percentDistance * initialPosition) - 400;
  }

  double _textSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 128.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 100.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 80.sp;
    }
    return 64.sp;
  }
}