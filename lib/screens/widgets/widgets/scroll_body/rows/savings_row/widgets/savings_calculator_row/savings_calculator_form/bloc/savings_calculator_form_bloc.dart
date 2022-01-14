import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:website/resources/helpers/debouncer.dart';
import 'package:website/resources/helpers/savings_calculator.dart';

part 'savings_calculator_form_event.dart';
part 'savings_calculator_form_state.dart';

class SavingsCalculatorFormBloc extends Bloc<SavingsCalculatorFormEvent, SavingsCalculatorFormState> {
  final Duration _debounceTime = const Duration(milliseconds: 300);
  
  SavingsCalculatorFormBloc()
    : super(SavingsCalculatorFormState.initial()) {
      _eventHandler();
  }

  void _eventHandler() {
    on<FieldVisibilityChanged>((event, emit) => _mapFieldVisibilityChangedToState(event: event, emit: emit));
    
    on<NumberTransactionsChanged>((event, emit) => _mapNumberTransactionsChangedToState(event: event, emit: emit), transformer: Debouncer.bounce(duration: _debounceTime));
    on<NumberTransactionsSubmitted>((event, emit) => _mapNumberTransactionsSubmittedToState(event: event, emit: emit));
    
    on<PercentFeeChanged>((event, emit) => _mapPercentFeeChangedToState(event: event, emit: emit), transformer: Debouncer.bounce(duration: _debounceTime));
    on<PercentFeeSubmitted>((event, emit) => _mapPercentFeeSubmittedToState(event: event, emit: emit));

    on<SetFeeChanged>((event, emit) => _mapSetFeeChangedToState(event: event, emit: emit), transformer: Debouncer.bounce(duration: _debounceTime));
    on<SetFeeSubmitted>((event, emit) => _mapSetFeeSubmittedToState(event: event, emit: emit));

    on<AverageTotalChanged>((event, emit) => _mapAverageTotalChangedToState(event: event, emit: emit), transformer: Debouncer.bounce(duration: _debounceTime));
    on<AverageTotalSubmitted>((event, emit) => _mapAverageTotalSubmittedToState(event: event, emit: emit));

    on<ResetForm>((event, emit) => _mapResetFormToState(emit: emit));
  }

  void _mapFieldVisibilityChangedToState({required FieldVisibilityChanged event, required Emitter<SavingsCalculatorFormState> emit}) {
    emit(state.update(isFieldVisible: event.fieldVisible));
  }
  
  void _mapNumberTransactionsChangedToState({required NumberTransactionsChanged event, required Emitter<SavingsCalculatorFormState> emit}) {
    if (event.numberTransactions.isNotEmpty) {
      final int? numberTransactions = int.tryParse(event.numberTransactions);
      emit(state.update(numberTransactions: numberTransactions, isFieldValid: numberTransactions != null));
    }
  }

  void _mapNumberTransactionsSubmittedToState({required NumberTransactionsSubmitted event, required Emitter<SavingsCalculatorFormState> emit}) {
    emit(state.update(numberTransactionsSubmitted: true, isFieldValid: false));
  }

  void _mapPercentFeeChangedToState({required PercentFeeChanged event, required Emitter<SavingsCalculatorFormState> emit}) {
    if (event.percentFee.isNotEmpty) {
      final double? percentFee = double.tryParse(event.percentFee);
      emit(state.update(percentTransactionFee: percentFee, isFieldValid: percentFee != null));
    }
  }

  void _mapPercentFeeSubmittedToState({required PercentFeeSubmitted event, required Emitter<SavingsCalculatorFormState> emit}) {
    emit(state.update(percentFeeSubmitted: true, isFieldValid: false));
  }

  void _mapSetFeeChangedToState({required SetFeeChanged event, required Emitter<SavingsCalculatorFormState> emit}) {
    if (event.setFee.isNotEmpty) {
      final int? setFee = int.tryParse(event.setFee);
      emit(state.update(setTransactionFee: setFee, isFieldValid: setFee != null));
    }
  }

  void _mapSetFeeSubmittedToState({required SetFeeSubmitted event, required Emitter<SavingsCalculatorFormState> emit}) {
    emit(state.update(setFeeSubmitted: true, isFieldValid: false));
  }

  void _mapAverageTotalChangedToState({required AverageTotalChanged event, required Emitter<SavingsCalculatorFormState> emit}) {
    if (event.averageTotal.isNotEmpty) {
      final int? averageTotalTransaction = int.tryParse(event.averageTotal);
      emit(state.update(averageTotalTransaction: averageTotalTransaction, isFieldValid: averageTotalTransaction != null));
    }
  }

  void _mapAverageTotalSubmittedToState({required AverageTotalSubmitted event, required Emitter<SavingsCalculatorFormState> emit}) {
    emit(state.update(averageTotalSubmitted: true, isFieldValid: false, formSubmitted: true));
  }

  void _mapResetFormToState({required Emitter<SavingsCalculatorFormState> emit}) {
    emit(SavingsCalculatorFormState.initial());
  }
}
