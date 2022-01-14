part of 'parallax_bloc.dart';

abstract class ParallaxEvent extends Equatable {
  const ParallaxEvent();

  @override
  List<Object> get props => [];
}

class ScrollUpdated extends ParallaxEvent {
  final double offset;

  const ScrollUpdated({required this.offset});

  @override
  List<Object> get props => [offset];

  @override
  String toString() => 'ScrollUpdated { offset: $offset }';
}