import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'savings_explanation_event.dart';
part 'savings_explanation_state.dart';

class SavingsExplanationBloc extends Bloc<SavingsExplanationEvent, SavingsExplanationState> {
  static const String brainAnimation = 'lotties/brain.zip';
  static const String registerAnimation = 'lotties/register.zip';
  static const String invoiceAnimation = 'lotties/invoice.zip';
  static const String piggyBankAnimation = 'lotties/piggy_bank.zip';
  static const String freeAnimation = 'lotties/free.zip';
  static const String coinsAnimation = 'lotties/coins.zip';

  SavingsExplanationBloc() : super(SavingsExplanationState.initial()) {
    _eventHandler();
  }

  void _eventHandler() {
    on<AnimationPlayed>((event, emit) => _mapAnimationPlayedToState(event: event, emit: emit));
  }

  void _mapAnimationPlayedToState({required AnimationPlayed event, required Emitter<SavingsExplanationState> emit}) {
    switch (event.animation) {
      case brainAnimation:
        emit(state.update(brainPlayed: true));
        break;
      case registerAnimation:
        emit(state.update(registerPlayed: true));
        break;
      case invoiceAnimation:
        emit(state.update(invoicePlayed: true));
        break;
      case piggyBankAnimation:
        emit(state.update(piggyBankPlayed: true));
        break;
      case freeAnimation:
        emit(state.update(freePlayed: true));
        break;
      case coinsAnimation:
        emit(state.update(coinsPlayed: true));
        break;
    }
  }

  bool animationPlayed({required String animation}) {
    switch (animation) {
      case brainAnimation:
        return state.brainPlayed;
      case registerAnimation:
        return state.registerPlayed;
      case invoiceAnimation:
        return state.invoicePlayed;
      case piggyBankAnimation:
        return state.piggyBankPlayed;
      case freeAnimation:
        return state.freePlayed;
      case coinsAnimation:
        return state.coinsPlayed;
      default:
        return false;
    }
  }
}
