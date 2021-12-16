import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/get_started_button_cubit.dart';

class GetStartedButton extends StatefulWidget {

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  double _iconSize = 70.sp;
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<GetStartedButtonCubit, bool>(
      listener: (context, isFocused) {
        _iconSize = isFocused ? 80.sp : 70.sp;
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
                  size: _iconSize,
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
                  fontSize: 50.sp,
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

  void _mouseEnter({required BuildContext context}) {
    BlocProvider.of<GetStartedButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit({required BuildContext context}) {
    BlocProvider.of<GetStartedButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _goToSignup() {
    
  }
}