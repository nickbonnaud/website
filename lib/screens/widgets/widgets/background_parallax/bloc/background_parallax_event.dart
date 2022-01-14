part of 'background_parallax_bloc.dart';

abstract class BackgroundParallaxEvent extends Equatable {
  const BackgroundParallaxEvent();

  @override
  List<Object> get props => [];
}

class ScrollChanged extends BackgroundParallaxEvent {
  final double absolutePositionY;

  const ScrollChanged({required this.absolutePositionY});

  @override
  List<Object> get props => [absolutePositionY];

  @override
  String toString() => 'ScrollChanged { absolutePositionY: $absolutePositionY }';
}

class BackgroundImageChanged extends BackgroundParallaxEvent {
  final String image;
  final double constantEntryPositionY;
  final double constantEntryDistanceFromTop;

  const BackgroundImageChanged({required this.image, required this.constantEntryPositionY, required this.constantEntryDistanceFromTop});

  @override
  List<Object> get props => [image, constantEntryPositionY, constantEntryDistanceFromTop];

  @override
  String toString() => '''BackgroundImageChanged {
    image: $image,
    constantEntryPositionY: $constantEntryPositionY,
    constantEntryDistanceFromTop: $constantEntryDistanceFromTop
  }''';
}
