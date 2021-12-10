import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

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
  
  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _didEnterView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        width: .15.sw,
        height: .15.sw,
      )
    );
  }

  Widget _text() {
    return Text(
      widget._text,
      style: TextStyle(
        fontSize: 28.sp
      ),
    );
  }
  
  void _playAnimation() {
    if (_iconController.isAnimating) return;
    _iconController.reset();
    _iconController.forward();
  }
  
  void _didEnterView() {
    if (_iconController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? iconObject = _iconGlobalKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || iconObject == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double iconObjectTop = iconObject.getTransformTo(businessListViewObject).getTranslation().y;

    final bool iconVisible = (iconObjectTop + _enterAnimationMinHeight) < listViewHeight;

    if (iconVisible) {
      _iconController.forward();
    }
  }
}