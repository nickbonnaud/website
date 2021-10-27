part of 'savings_calculator_bloc.dart';

abstract class SavingsCalculatorEvent extends Equatable {
  const SavingsCalculatorEvent();

  @override
  List<Object> get props => [];
}

class PercentTransactionFeeChanged extends SavingsCalculatorEvent {
  final double percentTransactionFee;

  const PercentTransactionFeeChanged({required this.percentTransactionFee});

  @override
  List<Object> get props => [percentTransactionFee];

  @override
  String toString() => 'PercentTransactionFeeChanged { percentTransactionFee: $percentTransactionFee }';
}

class SetTransactionFeeChanged extends SavingsCalculatorEvent {
  final int setTransactionFee;

  const SetTransactionFeeChanged({required this.setTransactionFee});

  @override
  List<Object> get props => [setTransactionFee];

  @override
  String toString() => 'SetTransactionFeeChanged { setTransactionFee: $setTransactionFee }';
}

class NumberCardTransactionsChanged extends SavingsCalculatorEvent {
  final int numberCardTransactions;

  const NumberCardTransactionsChanged({required this.numberCardTransactions});

  @override
  List<Object> get props => [numberCardTransactions];

  @override
  String toString() => 'NumberCardTransactionsChanged { numberCardTransactions: $numberCardTransactions }';
}

class AverageTotalTransactionChanged extends SavingsCalculatorEvent {
  final int averageTotalTransaction;

  const AverageTotalTransactionChanged({required this.averageTotalTransaction});

  @override
  List<Object> get props => [averageTotalTransaction];

  @override
  String toString() => 'AverageTotalTransactionChanged { averageTotalTransaction: $averageTotalTransaction }';
}

class PercentNovaTransactionsChanged extends SavingsCalculatorEvent {
  final double percentNovaTransactions;

  const PercentNovaTransactionsChanged({required this.percentNovaTransactions});

  @override
  List<Object> get props => [percentNovaTransactions];

  @override
  String toString() => 'PercentNovaTransactionsChanged { percentNovaTransactions: $percentNovaTransactions }';
}
