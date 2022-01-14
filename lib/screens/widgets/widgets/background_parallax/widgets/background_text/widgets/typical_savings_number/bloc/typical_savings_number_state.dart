part of 'typical_savings_number_bloc.dart';

@immutable
class TypicalSavingsNumberState extends Equatable {
  final bool animationCompleted;
  final double animationValue;

  const TypicalSavingsNumberState({required this.animationCompleted, required this.animationValue});

  factory TypicalSavingsNumberState.initial() {
    return const TypicalSavingsNumberState(animationCompleted: false, animationValue: 0);
  }

  TypicalSavingsNumberState update({bool? animationCompleted, double? animationValue}) {
    return TypicalSavingsNumberState(
      animationCompleted: animationCompleted ?? this.animationCompleted,
      animationValue: animationValue ?? this.animationValue
    );
  }

  @override
  List<Object?> get props => [animationCompleted, animationValue];

  @override
  String toString() => '''TypicalSavingsNumberState {
    animationCompleted: $animationCompleted,
    animationValue: $animationValue
  }''';
}
