import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/currency.dart';
import 'package:website/resources/helpers/savings_calculator.dart';

import 'bloc/typical_savings_number_bloc.dart';

class TypicalSavingsNumber extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;
  final GlobalKey _secondImageWindowKey;

  const TypicalSavingsNumber({
    required GlobalKey businessListViewKey,
    required ScrollController scrollController,
    required GlobalKey secondImageWindowKey
  })
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController,
      _secondImageWindowKey = secondImageWindowKey;

  @override
  State<TypicalSavingsNumber> createState() => _TypicalSavingsNumberState();
}

class _TypicalSavingsNumberState extends State<TypicalSavingsNumber> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 500;
  static const Curve _curve = Curves.linear;
  static const Duration _duration = Duration(seconds: 2);

  final SavingsCalculator _savingsCalculator = const SavingsCalculator();

  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  late Animation<double> _numberAnimation;

  late TypicalSavingsNumberBloc _numberBloc;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: _duration);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: _curve);
    
    _numberBloc = BlocProvider.of<TypicalSavingsNumberBloc>(context);

    widget._scrollController.addListener(_didEnterView);

    _numberAnimation = Tween<double>(begin: 0, end: _savingsCalculator.totalSavings.toDouble())
      .animate(_curvedAnimation);

    _numberAnimation.addListener(_animationValueChanged);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypicalSavingsNumberBloc, TypicalSavingsNumberState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedSize(
              duration: _duration,
              curve: _curve,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: state.animationCompleted ? .15.sw : 0,
              )
            ),

            Text(
              _formatSavingsValue(savings: state.animationValue, state: state),
              style: TextStyle(
                fontSize: 64.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _numberBloc.close();
    super.dispose();
  }

  String _formatSavingsValue({required double savings, required TypicalSavingsNumberState state}) {
    return state.animationCompleted
      ? Currency.create(cents: savings.round())
      : "";
  }
  
  void _didEnterView() {
    if (_numberBloc.state.animationCompleted) return;
    if (_animationController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? savingsNumber = widget._secondImageWindowKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || savingsNumber == null) return;
    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double savingsNumberTop = savingsNumber.getTransformTo(businessListViewObject).getTranslation().y;

    final bool savingsNumberVisible = (savingsNumberTop + _enterAnimationMinHeight) < listViewHeight;

    if (savingsNumberVisible) {
      _numberBloc.add(AnimationFinished());
      _animationController.forward();
    }
  }

  void _animationValueChanged() {
    _numberBloc.add(AnimationValueChanged(animationValue: _numberAnimation.value));
  }
}