import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

class SignupNowButton extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const SignupNowButton({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;
  
  @override
  State<SignupNowButton> createState() => _SignupNowButtonState();
}

class _SignupNowButtonState extends State<SignupNowButton> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _signupButtonKey = GlobalKey();
  
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _enterAnimation;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _enterAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero
    ).animate(_curvedAnimation);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _updateSignupButtonEnteredView();
      },
      child: SlideTransition(
        key: _signupButtonKey,
        position: _enterAnimation,
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            width: 125.w,
            height: 125.w
          ),
          child: ElevatedButton(
            onPressed: () => _goToSignup(),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 20,
              shape: const CircleBorder()
            )
          )
        )
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _goToSignup() {
    print('Go To Signup');
  }
  
  void _updateSignupButtonEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? signupButton = _signupButtonKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || signupButton == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double signupButtonTop = signupButton.getTransformTo(businessListViewObject).getTranslation().y;

    final bool signupButtonVisible = (signupButtonTop + _enterAnimationMinHeight) < listViewHeight;

    if (signupButtonVisible) {
      _animationController.forward();
    }
  }
}