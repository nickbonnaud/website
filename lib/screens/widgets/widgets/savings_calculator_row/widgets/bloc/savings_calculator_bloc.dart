import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'savings_calculator_event.dart';
part 'savings_calculator_state.dart';

class SavingsCalculatorBloc extends Bloc<SavingsCalculatorEvent, SavingsCalculatorState> {
  SavingsCalculatorBloc() : super(SavingsCalculatorState.initial()) {
    _eventHandler();
  }

  void _eventHandler() {
    on<PercentTransactionFeeChanged>((event, emit) => _mapPercentTransactionFeeChangedToState(event: event, emit: emit));
    on<SetTransactionFeeChanged>((event, emit) => _mapSetTransactionFeeChangedToState(event: event, emit: emit));
    on<NumberCardTransactionsChanged>((event, emit) => _mapNumberCardTransactionsChangedToState(event: event, emit: emit));
    on<AverageTotalTransactionChanged>((event, emit) => _mapAverageTotalTransactionChangedToState(event: event, emit: emit));
    on<PercentNovaTransactionsChanged>((event, emit) => _mapPercentNovaTransactionsChangedToState(event: event, emit: emit));
  }

  void _mapPercentTransactionFeeChangedToState({required PercentTransactionFeeChanged event, required Emitter<SavingsCalculatorState> emit}) {
    emit(state.update(percentTransactionFee: event.percentTransactionFee));
  }

  void _mapSetTransactionFeeChangedToState({required SetTransactionFeeChanged event, required Emitter<SavingsCalculatorState> emit}) {
    emit(state.update(setTransactionFee: event.setTransactionFee));
  }

  void _mapNumberCardTransactionsChangedToState({required NumberCardTransactionsChanged event, required Emitter<SavingsCalculatorState> emit}) {
    emit(state.update(numberCardTransactions: event.numberCardTransactions));
  }

  void _mapAverageTotalTransactionChangedToState({required AverageTotalTransactionChanged event, required Emitter<SavingsCalculatorState> emit}) {
    emit(state.update(averageTotalTransaction: event.averageTotalTransaction));
  }

  void _mapPercentNovaTransactionsChangedToState({required PercentNovaTransactionsChanged event, required Emitter<SavingsCalculatorState> emit}) {
    emit(state.update(percentNovaTransactions: event.percentNovaTransactions));
  }
}
