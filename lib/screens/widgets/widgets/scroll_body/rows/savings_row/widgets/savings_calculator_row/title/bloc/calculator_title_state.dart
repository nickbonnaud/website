part of 'calculator_title_bloc.dart';

@immutable
class CalculatorTitleState extends Equatable {
  final String exitTitle;
  final double exitOpacity;
  final String enterTitle;
  final double enterOpacity;

  const CalculatorTitleState({
    required this.exitTitle,
    required this.exitOpacity,
    required this.enterTitle,
    required this.enterOpacity
  });

  factory CalculatorTitleState.initial() {
    return const CalculatorTitleState(
      exitTitle: "How many card transactions do you take a year?",
      exitOpacity: 1,
      enterTitle: "What percentage of each sale does your current Point of Sale charge?",
      enterOpacity: 0
    );
  }

  CalculatorTitleState update({String? exitTitle, double? exitOpacity, String? enterTitle, double? enterOpacity}) {
    return CalculatorTitleState(
      exitTitle: exitTitle ?? this.exitTitle,
      exitOpacity: exitOpacity ?? this.exitOpacity,
      enterTitle: enterTitle ?? this.enterTitle,
      enterOpacity: enterOpacity ?? this.enterOpacity
    );
  }

  @override
  List<Object?> get props => [exitTitle, exitOpacity, enterTitle, enterOpacity];

  @override
  String toString() => '''CalculatorTitleState {
    exitTitle: $exitTitle,
    exitOpacity: $exitOpacity,
    enterTitle: $enterTitle,
    enterOpacity: $enterOpacity
  }''';
}
