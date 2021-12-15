import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/register_button_cubit.dart';

class RegisterButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State <RegisterButton> {
  double _iconSize = 80.sp;
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterButtonCubit, bool>(
      listener: (context, isFocused) {
        _iconSize = isFocused ? 80.sp : 70.sp;
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
                  size: _iconSize,
                  color: const Color(0xFF016FB9),
                ),
              );
            }
          ),
          icon: Text(
            "Register Today",
            style: TextStyle(
              fontSize: 50.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF016FB9)
            ),
          ),
        ),
      ),
    );
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