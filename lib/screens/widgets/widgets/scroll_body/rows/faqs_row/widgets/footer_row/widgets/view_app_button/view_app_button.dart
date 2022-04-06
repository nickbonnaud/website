import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'cubit/view_app_button_cubit.dart';

class ViewAppButton extends StatefulWidget {

  const ViewAppButton({Key? key})
    : super(key: key);
  
  @override
  State<ViewAppButton> createState() => _ViewAppButtonState();
}

class _ViewAppButtonState extends State<ViewAppButton> with SingleTickerProviderStateMixin {
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
        onPressed: () => _viewAppButtonPressed(),
        icon: Lottie.asset(
          "lotties/rocket.zip",
          controller: _iconController,
          width: _iconDimensions(),
          height: _iconDimensions()
        ),
        label: BlocBuilder<ViewAppButtonCubit, bool>(
          builder: (context, isFocused) {
            return Text(
              "Customer App",
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
      return 110.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 90.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 70.w;
    }
    return 40.w;
  }

  double _textSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 35.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 30.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 25.sp;
    }
    return 20.sp;
  }

  void _mouseEnter() {
    _playAnimation();
    BlocProvider.of<ViewAppButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit() {
    BlocProvider.of<ViewAppButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _playAnimation() {
    if (_iconController.isAnimating) return;
    _iconController.forward().then((_) =>  _iconController.reset());
  }

  void _viewAppButtonPressed() {
    // TODO
    // add go to customer app page
  }
}