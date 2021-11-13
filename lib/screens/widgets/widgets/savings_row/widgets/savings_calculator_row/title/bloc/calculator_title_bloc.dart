import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../savings_calculator_form/bloc/savings_calculator_form_bloc.dart';

part 'calculator_title_event.dart';
part 'calculator_title_state.dart';

class CalculatorTitleBloc extends Bloc<CalculatorTitleEvent, CalculatorTitleState> {
  late StreamSubscription _calculatorFormSubscription;
  
  CalculatorTitleBloc({required SavingsCalculatorFormBloc savingsCalculatorFormBloc}) : super(CalculatorTitleState.initial()) {
    _eventHandler();
    
    _calculatorFormSubscription = savingsCalculatorFormBloc.stream.listen((SavingsCalculatorFormState calculatorFormState) {
      if (calculatorFormState.isFieldVisible && !calculatorFormState.numberTransactionsSubmitted) {
        add(FieldIsVisible());
        _calculatorFormSubscription.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _calculatorFormSubscription.cancel();
    return super.close();
  }

  void _eventHandler() {
    on<ExitTitleChanged>((event, emit) => _mapExitTitleChangedToState(event: event, emit: emit));
    on<ExitOpacityChanged>((event, emit) => _mapExitOpacityChangedToState(event: event, emit: emit));
    on<EnterTitleChanged>((event, emit) => _mapEnterTitleChangedToState(event: event, emit: emit));
    on<EnterOpacityChanged>((event, emit) => _mapEnterOpacityChangedToState(event: event, emit: emit));
    on<FieldIsVisible>((event, emit) => _mapFieldIsVisibleToState(emit: emit));
  }

  void _mapExitTitleChangedToState({required ExitTitleChanged event, required Emitter<CalculatorTitleState> emit}) {
    emit(state.update(exitOpacity: 1));
    emit(state.update(exitTitle: _setExitTitle(state: event.calculatorFormState)));
  }

  void _mapExitOpacityChangedToState({required ExitOpacityChanged event, required Emitter<CalculatorTitleState> emit}) {
    emit(state.update(exitOpacity: event.opacity));
  }

  void _mapEnterTitleChangedToState({required EnterTitleChanged event, required Emitter<CalculatorTitleState> emit}) {
    emit(state.update(enterTitle: _setEnterTitle(state: event.calculatorFormState)));
  }

  void _mapEnterOpacityChangedToState({required EnterOpacityChanged event, required Emitter<CalculatorTitleState> emit}) {
    emit(state.update(enterOpacity: event.opacity));
  }

  void _mapFieldIsVisibleToState({required Emitter<CalculatorTitleState> emit}) {
    emit(state.update(exitTitle: "How many card transactions do you take a year?"));
  }

  String _setExitTitle({required SavingsCalculatorFormState state}) {
    String title = "";
    if (state.setFeeSubmitted) {
      title = "What is your average sale total?";
    } else if (state.percentFeeSubmitted) {
      title = "Does your current Point of Sale charge a fixed amount as well?";
    } else if (state.numberTransactionsSubmitted) {
      title = "What percentage of each sale does your current Point of Sale charge?";
    } else {
      title = "How many card transactions do you take a year?";
    }
    return title;
  }

  String _setEnterTitle({required SavingsCalculatorFormState state}) {
    String title = "";
    if (state.setFeeSubmitted) {
      title = "What is your average sale total?";
    } else if (state.percentFeeSubmitted) {
      title = "What is your average sale total?";
    } else if (state.numberTransactionsSubmitted) {
      title = "Does your current Point of Sale charge a fixed amount as well?";
    }
    return title;
  }
}
