class SavingsCalculator {
  static const double _novaPercentTransactionFee = .01;
  static const int _novaSetTransactionFee = 5;

  final int _numberTransactions;
  final double _percentTransactionFee;
  final int _setTransactionFee;
  final int _averageTotalTransaction;

  int get totalSavings => _totalSavingsPercentFee() + _totalSavingsSetFee();
  
  const SavingsCalculator({
    int numberTransactions = 20000,
    double percentTransactionFee = .029,
    int setTransactionFee = 10,
    int averageTotalTransaction = 2000
  })
    : _numberTransactions = numberTransactions,
      _percentTransactionFee = percentTransactionFee,
      _setTransactionFee = setTransactionFee,
      _averageTotalTransaction = averageTotalTransaction;
  
  int _totalSavingsPercentFee() {
    return ((_percentTransactionFee - _novaPercentTransactionFee) * (_numberTransactions * _averageTotalTransaction)).round();
  }

  int _totalSavingsSetFee() {
    return _numberTransactions * (_setTransactionFee - _novaSetTransactionFee);
  }
}