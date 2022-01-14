part of 'savings_calculator_form_bloc.dart';

abstract class SavingsCalculatorFormEvent extends Equatable {
  const SavingsCalculatorFormEvent();

  @override
  List<Object> get props => [];
}

class NumberTransactionsChanged extends SavingsCalculatorFormEvent {
  final String numberTransactions;

  const NumberTransactionsChanged({required this.numberTransactions});

  @override
  List<Object> get props => [numberTransactions];

  @override
  String toString() => 'NumberTransactionsChanged { numberTransactions: $numberTransactions }';
}

class NumberTransactionsSubmitted extends SavingsCalculatorFormEvent {
  final String numberTransactions;

  const NumberTransactionsSubmitted({required this.numberTransactions});

  @override
  List<Object> get props => [numberTransactions];

  @override
  String toString() => 'NumberTransactionsSubmitted { numberTransactions: $numberTransactions }';
}

class PercentFeeChanged extends SavingsCalculatorFormEvent {
  final String percentFee;

  const PercentFeeChanged({required this.percentFee});

  @override
  List<Object> get props => [percentFee];

  @override
  String toString() => 'PercentFeeChanged { percentFee: $percentFee }';
}

class PercentFeeSubmitted extends SavingsCalculatorFormEvent {
  final String percentFee;

  const PercentFeeSubmitted({required this.percentFee});

  @override
  List<Object> get props => [percentFee];

  @override
  String toString() => 'PercentFeeSubmitted { percentFee: $percentFee }';
}

class SetFeeChanged extends SavingsCalculatorFormEvent {
  final String setFee;

  const SetFeeChanged({required this.setFee});

  @override
  List<Object> get props => [setFee];

  @override
  String toString() => 'SetFeeChanged { setFee: $setFee }';
}

class SetFeeSubmitted extends SavingsCalculatorFormEvent {
  final String setFee;

  const SetFeeSubmitted({required this.setFee});

  @override
  List<Object> get props => [setFee];

  @override
  String toString() => 'SetFeeSubmitted { setFee: $setFee }';
}

class AverageTotalChanged extends SavingsCalculatorFormEvent {
  final String averageTotal;

  const AverageTotalChanged({required this.averageTotal});

  @override
  List<Object> get props => [averageTotal];

  @override
  String toString() => 'AverageTotalChanged { averageTotal: $averageTotal }';
}

class AverageTotalSubmitted extends SavingsCalculatorFormEvent {
  final String averageTotal;

  const AverageTotalSubmitted({required this.averageTotal});

  @override
  List<Object> get props => [averageTotal];

  @override
  String toString() => 'AverageTotalSubmitted { averageTotal: $averageTotal }';
}

class FieldVisibilityChanged extends SavingsCalculatorFormEvent {
  final bool fieldVisible;

  const FieldVisibilityChanged({required this.fieldVisible});

  @override
  List<Object> get props => [fieldVisible];

  @override
  String toString() => 'FieldVisibilityChanged { fieldVisible: $fieldVisible }';
}

class ResetForm extends SavingsCalculatorFormEvent {}