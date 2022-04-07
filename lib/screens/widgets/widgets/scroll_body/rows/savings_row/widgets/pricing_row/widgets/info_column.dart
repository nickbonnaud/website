import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

class InfoColumn extends StatefulWidget {

  const InfoColumn({Key? key})
    : super(key: key);

  @override
  State<InfoColumn> createState() => _InfoColumnState();
}

class _InfoColumnState extends State<InfoColumn> with SingleTickerProviderStateMixin {
  final TextSizer _textSizer = const TextSizer();
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 100);

  late final AnimationController _animationController;
  late final Animation<Offset> _enterAnimation;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _enterAnimation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _updateInfoEnteredView();
      },
      child: SlideTransition(
        key: BlocProvider.of<KeyHolderCubit>(context).state.pricingInfoKey,
        position: _enterAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "1% ",
                style: TextStyle(
                  fontSize: _numberTextSize(),
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: "of total sale",
                    style: TextStyle(
                      fontSize: _normalTextSize(context: context),
                      fontWeight: FontWeight.normal
                    ),
                  )
                ]
              )
            ),
            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                text: "5¢ ",
                style: TextStyle(
                  fontSize: _numberTextSize(),
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: "per transaction",
                    style: TextStyle(
                      fontSize: _normalTextSize(context: context),
                      fontWeight: FontWeight.normal
                    ),
                  )
                ]
              )
            ),
            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                text: "\$0 ",
                style: TextStyle(
                  fontSize: _numberTextSize(),
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: "setup costs",
                    style: TextStyle(
                      fontSize: _normalTextSize(context: context),
                      fontWeight: FontWeight.normal
                    ),
                  )
                ]
              )
            ),
            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                text: "\$0 ",
                style: TextStyle(
                  fontSize: _numberTextSize(),
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: "monthly fees",
                    style: TextStyle(
                      fontSize: _normalTextSize(context: context),
                      fontWeight: FontWeight.normal
                    ),
                  )
                ]
              )
            )
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _numberTextSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 45.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 45.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 40.sp;
    }
    return 40.sp;
  }
  
  double _normalTextSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 40.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 35.sp;
    }
    return 32.sp;
  }

  void _updateInfoEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    KeyHolderCubit cubit = BlocProvider.of<KeyHolderCubit>(context);
    
    bool iconVisible = _visibilityFinder.isVisible(parentKey: cubit.state.mainScrollKey, childKey: cubit.state.pricingInfoKey);
    
    if (iconVisible) {
      _animationController.forward();
    }
  }
}