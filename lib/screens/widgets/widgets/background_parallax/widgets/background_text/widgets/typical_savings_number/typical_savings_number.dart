import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/currency.dart';
import 'package:website/resources/helpers/savings_calculator.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import 'bloc/typical_savings_number_bloc.dart';

class TypicalSavingsNumber extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final GlobalKey _secondImageWindowKey;

  const TypicalSavingsNumber({
    required GlobalKey businessListViewKey,
    required GlobalKey secondImageWindowKey
  })
    : _businessListViewKey = businessListViewKey,
      _secondImageWindowKey = secondImageWindowKey;

  @override
  State<TypicalSavingsNumber> createState() => _TypicalSavingsNumberState();
}

class _TypicalSavingsNumberState extends State<TypicalSavingsNumber> with TickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 500;
  static const Curve _curve = Curves.linear;
  static const Duration _duration = Duration(seconds: 2);

  final SavingsCalculator _savingsCalculator = const SavingsCalculator();

  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  late Animation<double> _numberAnimation;

  late VisibilityFinder _visibilityFinder;

  late TypicalSavingsNumberBloc _numberBloc;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: _duration);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: _curve);

    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: widget._secondImageWindowKey, enterAnimationMinHeight: _enterAnimationMinHeight);
    
    _numberBloc = BlocProvider.of<TypicalSavingsNumberBloc>(context);

    _numberAnimation = Tween<double>(begin: 0, end: _savingsCalculator.totalSavings.toDouble())
      .animate(_curvedAnimation);

    _numberAnimation.addListener(_animationValueChanged);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _didEnterView();
      },
      child: BlocBuilder<TypicalSavingsNumberBloc, TypicalSavingsNumberState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedSize(
                duration: _duration,
                curve: _curve,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: state.animationCompleted ? 150.sp : 0,
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
      ),
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

    bool savingsNumberVisible = _visibilityFinder.isVisible();

    if (savingsNumberVisible) {
      _numberBloc.add(AnimationFinished());
      _animationController.forward();
    }
  }

  void _animationValueChanged() {
    _numberBloc.add(AnimationValueChanged(animationValue: _numberAnimation.value));
  }
}