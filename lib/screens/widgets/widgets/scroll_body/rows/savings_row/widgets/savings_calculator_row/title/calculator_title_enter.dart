import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'bloc/calculator_title_bloc.dart';

import '../savings_calculator_form/bloc/savings_calculator_form_bloc.dart';

class CalculatorTitleEnter extends StatefulWidget {

  const CalculatorTitleEnter({Key? key})
    : super(key: key);
  
  @override
  State<CalculatorTitleEnter> createState() => _CalculatorTitleEnterState();
}

class _CalculatorTitleEnterState extends State<CalculatorTitleEnter> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _exitAnimation;

  late final CalculatorTitleBloc _titleBloc;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _exitAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: const Offset(0, 0)
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _titleBloc = BlocProvider.of<CalculatorTitleBloc>(context);

    _animationController.addListener(_opacityChanged);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<SavingsCalculatorFormBloc, SavingsCalculatorFormState>(
      listenWhen: (previousState, currentState) => _shouldPlayAnimation(previousState: previousState, currentState: currentState),
      listener: (context, state) => _playAnimation(state: state),
      child: SlideTransition(
        position: _exitAnimation,
        child: BlocBuilder<CalculatorTitleBloc, CalculatorTitleState>(
          builder: (context, state) {
            return Text(
              state.enterTitle,
              style: TextStyle(
                fontSize: _titleTextSize(),
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(state.enterOpacity)
              )
            );
          }
        )
      )
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleBloc.close();
    super.dispose();
  }

  bool _shouldPlayAnimation({required SavingsCalculatorFormState previousState, required SavingsCalculatorFormState currentState}) {
    bool shouldPlay = false;
    if (!previousState.numberTransactionsSubmitted && currentState.numberTransactionsSubmitted) {
      shouldPlay = true;
    } else if (!previousState.percentFeeSubmitted && currentState.percentFeeSubmitted) {
      shouldPlay = true;
    } else if(!previousState.setFeeSubmitted && currentState.setFeeSubmitted) {
      shouldPlay = true;
    } else if (!previousState.averageTotalSubmitted && currentState.averageTotalSubmitted) {
      shouldPlay = true;
    }
    return shouldPlay;
  }

  void _playAnimation({required SavingsCalculatorFormState state}) {
    _animationController.forward().then((value) => _resetAnimation(state: state));
  }

  void _resetAnimation({required SavingsCalculatorFormState state}) {
    _titleBloc.add(EnterTitleChanged(calculatorFormState: state));
    _animationController.reset();
  }

  void _opacityChanged() {
    _titleBloc.add(EnterOpacityChanged(opacity: _animationController.value));
  }

  double _titleTextSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 60.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 50.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 30.sp;
    }
    return 40.sp;
  }
}