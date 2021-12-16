import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

class InfoColumn extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const InfoColumn({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<InfoColumn> createState() => _InfoColumnState();
}

class _InfoColumnState extends State<InfoColumn> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _infoGlobalKey = GlobalKey();

  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _enterAnimation;

  late VisibilityFinder _visibilityFinder;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _enterAnimation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero
    ).animate(_curvedAnimation);

    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _infoGlobalKey, enterAnimationMinHeight: _enterAnimationMinHeight);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _updateInfoEnteredView();
      },
      child: SlideTransition(
        key: _infoGlobalKey,
        position: _enterAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "1%",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "of total sale",
                  style: TextStyle(
                    fontSize: 28.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  "5¢",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "per transaction",
                  style: TextStyle(
                    fontSize: 28.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  "\$0",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "setup costs",
                  style: TextStyle(
                    fontSize: 28.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  "\$0",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "monthly fees",
                  style: TextStyle(
                    fontSize: 28.sp,
                  ),
                )
              ],
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

  void _updateInfoEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    bool iconVisible = _visibilityFinder.isVisible();
    
    if (iconVisible) {
      _animationController.forward();
    }
  }
}