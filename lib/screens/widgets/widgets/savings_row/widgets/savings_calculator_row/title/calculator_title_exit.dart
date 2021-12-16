import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/calculator_title_bloc.dart';

import '../savings_calculator_form/bloc/savings_calculator_form_bloc.dart';

class CalculatorTitleExit extends StatefulWidget {
  
  @override
  State<CalculatorTitleExit> createState() => _CalculatorTitleExit();
}

class _CalculatorTitleExit extends State<CalculatorTitleExit> with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 1);
  
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _exitAnimation;
  
  late final CalculatorTitleBloc _titleBloc;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: _duration);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _exitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0)
    ).animate(_curvedAnimation);

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
              state.exitTitle,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(state.exitOpacity)
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

  void _opacityChanged() {
    _titleBloc.add(ExitOpacityChanged(opacity: 1 - _animationController.value));
  }

  void _resetAnimation({required SavingsCalculatorFormState state}) {
    _titleBloc.add(ExitTitleChanged(calculatorFormState: state));
    _animationController.reset();
  }
}