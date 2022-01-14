part of 'typical_savings_number_bloc.dart';

abstract class TypicalSavingsNumberEvent extends Equatable {
  const TypicalSavingsNumberEvent();

  @override
  List<Object> get props => [];
}

class AnimationFinished extends TypicalSavingsNumberEvent {}

class AnimationValueChanged extends TypicalSavingsNumberEvent {
  final double animationValue;

  const AnimationValueChanged({required this.animationValue});

  @override
  List<Object> get props => [animationValue];

  @override
  String toString() => 'AnimationValueChanged { animationValue: $animationValue }';
}
