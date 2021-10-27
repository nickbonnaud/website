part of 'savings_calculator_bloc.dart';

@immutable
class SavingsCalculatorState extends Equatable {
  final double _novaPercentTransactionFee = .01;
  final int _novaSetTransactionFee = 5;
  
  final double percentTransactionFee;
  final int setTransactionFee;
  final int numberCardTransactions;
  final int averageTotalTransaction;
  final double percentNovaTransactions;

  const SavingsCalculatorState({
    required this.percentTransactionFee,
    required this.setTransactionFee,
    required this.numberCardTransactions,
    required this.averageTotalTransaction,
    required this.percentNovaTransactions,
  });

  int get _totalSavingsPercentTransaction => ((percentTransactionFee - _novaPercentTransactionFee) * (numberCardTransactions * averageTotalTransaction)).round();
  int get _totalSavingsSetTransactionFee => numberCardTransactions * (setTransactionFee - _novaSetTransactionFee);
  
  int get totalSavings => _totalSavingsPercentTransaction + _totalSavingsSetTransactionFee;

  factory SavingsCalculatorState.initial() {
    return const SavingsCalculatorState(
      percentTransactionFee: .029,
      setTransactionFee: 10,
      numberCardTransactions: 10000,
      averageTotalTransaction: 2000,
      percentNovaTransactions: .50,
    );
  }

  SavingsCalculatorState update({
    double? percentTransactionFee,
    int? setTransactionFee,
    int? numberCardTransactions,
    int? averageTotalTransaction,
    double? percentNovaTransactions
  }) => SavingsCalculatorState(
    percentTransactionFee: percentTransactionFee ?? this.percentTransactionFee,
    setTransactionFee: setTransactionFee ?? this.setTransactionFee,
    numberCardTransactions: numberCardTransactions ?? this.numberCardTransactions,
    averageTotalTransaction: averageTotalTransaction ?? this.averageTotalTransaction,
    percentNovaTransactions: percentNovaTransactions ?? this.percentNovaTransactions
  );
  
  @override
  List<Object> get props => [
    percentTransactionFee,
    setTransactionFee,
    numberCardTransactions,
    averageTotalTransaction,
    percentNovaTransactions
  ];

  @override
  String toString() {
    return '''SavingsCalculatorState {
      percentTransactionFee: $percentTransactionFee,
      setTransactionFee: $setTransactionFee,
      numberCardTransactions: $numberCardTransactions,
      averageTotalTransaction: $averageTotalTransaction,
      percentNovaTransactions: $percentNovaTransactions
    }''';
  }
}
