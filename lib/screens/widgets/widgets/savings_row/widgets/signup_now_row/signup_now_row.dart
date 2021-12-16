import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/signup_now_row_cubit.dart';

class SignupNowRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupNowRowState();
}

class  _SignupNowRowState extends State<SignupNowRow> {
  double _iconSize = 80.sp;
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupNowRowCubit, bool>(
      listener: (context, isFocused) {
        _iconSize = isFocused ? 90.sp : 80.sp;
      },
      child: MouseRegion(
        onEnter: (_) => _mouseEnter(context: context),
        onExit: (_) => _mouseExit(context: context),
        child: TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.transparent)
          ),
          onPressed: () => _goToSignup(),
          label: BlocBuilder<SignupNowRowCubit, bool>(
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
            },
          ),
          icon: BlocBuilder<SignupNowRowCubit, bool>(
            builder: (context, isFocused) {
              return Text(
                "Get Started Now",
                style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                  decoration: isFocused ? TextDecoration.underline : TextDecoration.none
                ),
              );
            }
          )
        )
      ),
    );
  }

  void _mouseEnter({required BuildContext context}) {
    BlocProvider.of<SignupNowRowCubit>(context).hoverStatusChanged(isHovered: true);
  }

  void _mouseExit({required BuildContext context}) {
    BlocProvider.of<SignupNowRowCubit>(context).hoverStatusChanged(isHovered: false);
  }

  void _goToSignup() {
    
  }
}