part of 'calculator_title_bloc.dart';

abstract class CalculatorTitleEvent extends Equatable {
  const CalculatorTitleEvent();

  @override
  List<Object> get props => [];
}

class ExitTitleChanged extends CalculatorTitleEvent {
  final SavingsCalculatorFormState calculatorFormState;

  const ExitTitleChanged({required this.calculatorFormState});

  @override
  List<Object> get props => [calculatorFormState];

  @override
  String toString() => 'TitleChanged { calculatorFormState: $calculatorFormState }';
}

class ExitOpacityChanged extends CalculatorTitleEvent {
  final double opacity;

  const ExitOpacityChanged({required this.opacity});

  @override
  List<Object> get props => [opacity];

  @override
  String toString() => 'OpacityChanged { opacity: $opacity }';
}

class EnterTitleChanged extends CalculatorTitleEvent {
  final SavingsCalculatorFormState calculatorFormState;

  const EnterTitleChanged({required this.calculatorFormState});

  @override
  List<Object> get props => [calculatorFormState];

  @override
  String toString() => 'TitleChanged { calculatorFormState: $calculatorFormState }';
}

class EnterOpacityChanged extends CalculatorTitleEvent {
  final double opacity;

  const EnterOpacityChanged({required this.opacity});

  @override
  List<Object> get props => [opacity];

  @override
  String toString() => 'OpacityChanged { opacity: $opacity }';
}

class FieldIsVisible extends CalculatorTitleEvent {}