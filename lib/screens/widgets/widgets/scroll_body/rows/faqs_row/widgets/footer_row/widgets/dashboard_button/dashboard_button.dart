import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'cubit/dashboard_button_cubit.dart';

class DashboardButton extends StatefulWidget {
  
  const DashboardButton({Key? key})
    : super(key: key);
  
  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> with SingleTickerProviderStateMixin {
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _mouseEnter(),
      onExit: (_) => _mouseExit(),
      child: TextButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent)
        ),
        onPressed: () => _loginButtonPressed(),
        icon: Lottie.asset(
          "lotties/dashboard.zip",
          controller: _iconController,
          width: _iconDimensions(),
          height: _iconDimensions()
        ),
        label: BlocBuilder<DashboardButtonCubit, bool>(
          builder: (context, isFocused) {
            return Text(
              "Dashboard",
              style: TextStyle(
                fontSize: _textSize(),
                decoration: isFocused ? TextDecoration.underline : TextDecoration.none
              ),
            );
          }
        )
      ),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  double _iconDimensions() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 115.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 95.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 70.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 70.w;
    }
    return 50.w;
  }

  double _textSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 30.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 25.sp;
    }
    return 28.sp;
  }

  void _mouseEnter() {
    _playAnimation();
    BlocProvider.of<DashboardButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit() {
    BlocProvider.of<DashboardButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _playAnimation() {
    if (_iconController.isAnimating) return;
    _iconController.forward().then((_) =>  _iconController.reset());
  }

  void _loginButtonPressed() {
    // TODO
    // add go to login
  }
}