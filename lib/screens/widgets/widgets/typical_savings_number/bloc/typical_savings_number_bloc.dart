import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'typical_savings_number_event.dart';
part 'typical_savings_number_state.dart';

class TypicalSavingsNumberBloc extends Bloc<TypicalSavingsNumberEvent, TypicalSavingsNumberState> {
  TypicalSavingsNumberBloc() : super(TypicalSavingsNumberState.initial()) {
    _eventHandler();
  }

  void _eventHandler() {
    on<AnimationFinished>((event, emit) => _mapAnimationFinishedToState(emit: emit));
    on<AnimationValueChanged>((event, emit) => _mapAnimationValueChangedToState(event: event, emit: emit));
  }

  void _mapAnimationFinishedToState({required Emitter<TypicalSavingsNumberState> emit}) {
    emit(state.update(animationCompleted: true));
  }

  void _mapAnimationValueChangedToState({required AnimationValueChanged event, required Emitter<TypicalSavingsNumberState> emit}) {
    emit(state.update(animationValue: event.animationValue));
  }
}
