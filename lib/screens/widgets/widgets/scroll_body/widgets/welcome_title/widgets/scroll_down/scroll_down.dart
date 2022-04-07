import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';


class ScrollDown extends StatefulWidget {

  const ScrollDown({Key? key})
    : super(key: key);
  
  @override
  State<ScrollDown> createState() => _ScrollDownState();
}

class _ScrollDownState extends State<ScrollDown> with SingleTickerProviderStateMixin {  
  late final AnimationController _controller;
  late final Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationOffset = Tween<Offset>(
      begin: const Offset(0, .3),
      end: const Offset(0, -.3)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInBack));
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _dynamicWidth(),
      height: _dynamicHeight(),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: 2,
          color: Colors.white
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: SlideTransition(
        position: _animationOffset,
        child: Container(
          width: _dynamicWidth(),
          height: _dynamicWidth(),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _dynamicWidth() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 100.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 50.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 35.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 30.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_DESKTOP')) {
      return 25.sp;
    }
    return 20.sp;
  }

  double _dynamicHeight() {
    return 2.5 * _dynamicWidth();
  }
}