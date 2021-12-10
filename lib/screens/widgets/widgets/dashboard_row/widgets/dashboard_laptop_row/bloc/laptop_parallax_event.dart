part of 'laptop_parallax_bloc.dart';

abstract class LaptopParallaxEvent extends Equatable {
  const LaptopParallaxEvent();

  @override
  List<Object?> get props => [];
}

class ImageVisibilityChanged extends LaptopParallaxEvent {
  final bool isImageVisible;
  final double? entryPosition;

  const ImageVisibilityChanged({required this.isImageVisible, required this.entryPosition});

  @override
  List<Object?> get props => [isImageVisible, entryPosition];

  @override
  String toString() => 'ImageVisibilityChanged { isImageVisible: $isImageVisible, entryPosition: $entryPosition }';
}

class CurrentPositionChanged extends LaptopParallaxEvent {
  final double currentPosition;

  const CurrentPositionChanged({required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];

  @override
  String toString() => 'CurrentPositionChanged { currentPosition: $currentPosition }';
}