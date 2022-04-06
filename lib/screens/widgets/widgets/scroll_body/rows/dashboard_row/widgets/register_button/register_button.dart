import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'cubit/register_button_cubit.dart';

class RegisterButton extends StatefulWidget {

  const RegisterButton({Key? key})
    : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  double _iconSize = 90.sp;
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterButtonCubit, bool>(
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
          label: BlocBuilder<RegisterButtonCubit, bool>(
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
          icon: BlocBuilder<RegisterButtonCubit, bool>(
            builder: (context, isFocused) {
              return Text(
                "Register Today",
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
    BlocProvider.of<RegisterButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit() {
    BlocProvider.of<RegisterButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _goToSignup() {
    
  }
}