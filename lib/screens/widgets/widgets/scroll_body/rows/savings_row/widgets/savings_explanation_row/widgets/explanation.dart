import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

class Explanation extends StatefulWidget {
  final String _text;
  final String _animationPath;
  final GlobalKey _businessListViewKey;

  const Explanation({
    required String text,
    required String animationPath,
    required GlobalKey businessListViewKey,
  })
    : _text = text,
      _animationPath = animationPath,
      _businessListViewKey = businessListViewKey; 

  @override
  State<Explanation> createState() => _ExplanationState();
}

class _ExplanationState extends State<Explanation> with SingleTickerProviderStateMixin {
  final double _enterAnimationMinHeight = .4.sh;
  final GlobalKey _iconGlobalKey = GlobalKey();
  
  late AnimationController _iconController;
  late VisibilityFinder _visibilityFinder;
  
  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _iconGlobalKey, enterAnimationMinHeight: _enterAnimationMinHeight);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _didEnterView();
      },
      child: Column(
        crossAxisAlignment: ResponsiveWrapper.of(context).isLargerThan(TABLET)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
        children: [
          Align(
            child: _icon()
          ),
          SizedBox(height: 10.h),
          _text()
        ],
      )
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  Widget _icon() {
    return MouseRegion(
      onEnter: (_) => _playAnimation(),
      child: Lottie.asset(
        widget._animationPath,
        key: _iconGlobalKey,
        controller: _iconController,
        width: _iconDimensions(),
        height: _iconDimensions()
      )
    );
  }

  Widget _text() {
    return Text(
      widget._text,
      style: TextStyle(
        fontSize: _textSize()
      ),
    );
  }

  double _iconDimensions() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .35.sw;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .25.sw;
    }
    return .15.sw;
  }
  
  double _textSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 50.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 40.sp;
    }
    return 30.sp;
  }
  
  void _playAnimation() {
    if (_iconController.isAnimating) return;
    _iconController.forward().then((_) => _iconController.reset());
  }
  
  void _didEnterView() {
    if (_iconController.status != AnimationStatus.dismissed) return;

    bool iconVisible = _visibilityFinder.isVisible();

    if (iconVisible) {
      _iconController.forward().then((value) => _iconController.reset());
    }
  }
}