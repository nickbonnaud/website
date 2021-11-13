import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupNowText extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const SignupNowText({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;

  @override
  State<SignupNowText> createState() => _SignupNowTextState();
}

class _SignupNowTextState extends State<SignupNowText> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _signupTextKey = GlobalKey();
  
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _enterAnimation;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _enterAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero
    ).animate(_curvedAnimation);

    widget._scrollController.addListener(_updateSignupTextEnteredView);
  }
  
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      key: _signupTextKey,
      position: _enterAnimation,
      child: Text(
        "Get Started Now!",
        style: TextStyle(
          fontSize: 60.sp,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateSignupTextEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? signupText = _signupTextKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || signupText == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double signupTextTop = signupText.getTransformTo(businessListViewObject).getTranslation().y;

    final bool signupTextVisible = (signupTextTop + _enterAnimationMinHeight) < listViewHeight;

    if (signupTextVisible) {
      _animationController.forward();
    }
  }
}