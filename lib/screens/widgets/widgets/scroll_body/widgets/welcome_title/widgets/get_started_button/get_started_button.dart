import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'cubit/get_started_button_cubit.dart';

class GetStartedButton extends StatefulWidget {

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  double _iconSize = 90.sp;
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<GetStartedButtonCubit, bool>(
      listener: (context, isFocused) {
        _iconSize = isFocused ? 100.sp : 90.sp;
      },
      child: MouseRegion(
        onEnter: (_) => _mouseEnter(context: context),
        onExit: (_) => _mouseExit(context: context),
        child: TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.transparent)
          ),
          onPressed:() => _goToSignup(),
          label: BlocBuilder<GetStartedButtonCubit, bool>(
            builder: (_, __) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
                child: Icon(
                  Icons.chevron_right,
                  size: _iconSize + _textSizeAdjustment(),
                  color: const Color(0xFF016FB9),
                ),
              );
            }
          ),
          icon: BlocBuilder<GetStartedButtonCubit, bool>(
            builder: (context, isFocused) {
              return Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 70.sp + _textSizeAdjustment(),
                  fontWeight: FontWeight.bold,
                  decoration: isFocused ? TextDecoration.underline : TextDecoration.none
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  double _textSizeAdjustment() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 20.sp;
    }
    return 0;
  }
  
  void _mouseEnter({required BuildContext context}) {
    BlocProvider.of<GetStartedButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit({required BuildContext context}) {
    BlocProvider.of<GetStartedButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _goToSignup() {
    
  }
}