part of 'savings_explanation_bloc.dart';

abstract class SavingsExplanationEvent extends Equatable {
  const SavingsExplanationEvent();

  @override
  List<Object> get props => [];
}

class AnimationPlayed extends SavingsExplanationEvent {
  final String animation;

  const AnimationPlayed({required this.animation});

  @override
  List<Object> get props => [animation];

  @override
  String toString() => 'AnimationPlayed { animation: $animation }';
}
