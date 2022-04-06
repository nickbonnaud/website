import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'cubit/ready_button_cubit.dart';

class ReadyButton extends StatefulWidget {

  const ReadyButton({Key? key})
    : super(key: key);
  
  @override
  State<ReadyButton> createState() => _ReadyButtonState();
}

class _ReadyButtonState extends State<ReadyButton> {
  double _iconSize = 90.sp;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadyButtonCubit, bool>(
      listener: (context, isFocused) {
        _iconSize = isFocused ? 100.sp : 90.sp;
      },
      child: MouseRegion(
        onEnter: (_) => _mouseEnter(),
        onExit: (_) => _mouseExit(),
        child: TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.transparent)
          ),
          onPressed: () => _goToSignup(),
          label: BlocBuilder<ReadyButtonCubit, bool>(
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
          icon: BlocBuilder<ReadyButtonCubit, bool>(
            builder: (context, isFocused) {
              return Text(
                "Ready to Start",
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

  void _mouseEnter() {
    BlocProvider.of<ReadyButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit() {
    BlocProvider.of<ReadyButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _goToSignup() {
    
  }
}