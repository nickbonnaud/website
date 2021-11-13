part of 'savings_calculator_form_bloc.dart';

@immutable
class SavingsCalculatorFormState extends Equatable {

  final bool isFieldVisible;
  final int? numberTransactions;
  final bool numberTransactionsSubmitted;
  final double? percentTransactionFee;
  final bool percentFeeSubmitted;
  final int? setTransactionFee;
  final bool setFeeSubmitted;
  final int? averageTotalTransaction;
  final bool averageTotalSubmitted;
  final bool isFieldValid;
  final bool formSubmitted;
  
  int get totalSavings => SavingsCalculator(
    numberTransactions: numberTransactions!,
    percentTransactionFee: percentTransactionFee! / 100,
    setTransactionFee: setTransactionFee!,
    averageTotalTransaction: averageTotalTransaction! * 100
  ).totalSavings;
  
  const SavingsCalculatorFormState({
    required this.isFieldVisible,
    this.numberTransactions,
    required this.numberTransactionsSubmitted,
    this.percentTransactionFee,
    required this.percentFeeSubmitted,
    this.setTransactionFee,
    required this.setFeeSubmitted,
    this.averageTotalTransaction,
    required this.averageTotalSubmitted,
    required this.isFieldValid,
    required this.formSubmitted
  });

  factory SavingsCalculatorFormState.initial() {
    return const SavingsCalculatorFormState(
      isFieldVisible: false,
      numberTransactionsSubmitted: false,
      percentFeeSubmitted: false,
      setFeeSubmitted: false,
      averageTotalSubmitted: false,
      isFieldValid: true,
      formSubmitted: false
    );
  }

  SavingsCalculatorFormState update({
    bool? isFieldVisible,
    int? numberTransactions,
    bool? numberTransactionsSubmitted,
    double? percentTransactionFee,
    bool? percentFeeSubmitted,
    int? setTransactionFee,
    bool? setFeeSubmitted,
    int? averageTotalTransaction,
    bool? averageTotalSubmitted,
    bool? isFieldValid,
    bool? formSubmitted
  }) => SavingsCalculatorFormState(
    isFieldVisible: isFieldVisible ?? this.isFieldVisible,
    numberTransactions: numberTransactions ?? this.numberTransactions,
    numberTransactionsSubmitted: numberTransactionsSubmitted ?? this.numberTransactionsSubmitted,
    percentTransactionFee: percentTransactionFee ?? this.percentTransactionFee,
    percentFeeSubmitted: percentFeeSubmitted ?? this.percentFeeSubmitted,
    setTransactionFee: setTransactionFee ?? this.setTransactionFee,
    setFeeSubmitted: setFeeSubmitted ?? this.setFeeSubmitted,
    averageTotalTransaction: averageTotalTransaction ?? this.averageTotalTransaction,
    averageTotalSubmitted: averageTotalSubmitted ?? this.averageTotalSubmitted,
    isFieldValid: isFieldValid ?? this.isFieldValid,
    formSubmitted: formSubmitted ?? this.formSubmitted
  );

  @override
  List<Object?> get props => [
    isFieldVisible,
    numberTransactions,
    numberTransactionsSubmitted,
    percentTransactionFee,
    percentFeeSubmitted,
    setTransactionFee,
    setFeeSubmitted,
    averageTotalTransaction,
    averageTotalSubmitted,
    isFieldValid,
    formSubmitted
  ];

  @override
  String toString() => '''SavingsCalculatorFormState {
    isFieldVisible: $isFieldVisible
    numberTransactions: $numberTransactions,
    numberTransactionsSubmitted: $numberTransactionsSubmitted,
    percentTransactionFee: $percentTransactionFee,
    percentFeeSubmitted: $percentFeeSubmitted,
    setTransactionFee: $setTransactionFee,
    setFeeSubmitted: $setFeeSubmitted,
    averageTotalTransaction: $averageTotalTransaction,
    averageTotalSubmitted: $averageTotalSubmitted,
    isFieldValid: $isFieldValid,
    formSubmitted: $formSubmitted
  }''';
}

