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

class BackgroundChanged extends ParallaxEvent {
  final String newBackground;
  final double currentOffset;
  final double offsetAdjustment;

  const BackgroundChanged({
    required this.newBackground,
    required this.currentOffset,
    required this.offsetAdjustment
  });

  @override
  List<Object> get props => [newBackground, currentOffset, offsetAdjustment];

  @override
  String toString() => 'BackgroundChanged { newBackground: $newBackground, currentOffset: $currentOffset, offsetAdjustment: $offsetAdjustment }';
}