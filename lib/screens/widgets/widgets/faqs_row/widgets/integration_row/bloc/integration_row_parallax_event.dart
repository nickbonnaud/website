part of 'integration_row_parallax_bloc.dart';

abstract class IntegrationRowParallaxEvent extends Equatable {
  const IntegrationRowParallaxEvent();

  @override
  List<Object?> get props => [];
}

class ImageVisibilityChanged extends IntegrationRowParallaxEvent {
  final bool isImageVisible;
  final double? entryPosition;

  const ImageVisibilityChanged({required this.isImageVisible, required this.entryPosition});

  @override
  List<Object?> get props => [isImageVisible, entryPosition];

  @override
  String toString() => 'ImageVisibilityChanged { isImageVisible: $isImageVisible, entryPosition: $entryPosition }';
}

class CurrentPositionChanged extends IntegrationRowParallaxEvent {
  final double currentPosition;

  const CurrentPositionChanged({required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];

  @override
  String toString() => 'CurrentPositionChanged { currentPosition: $currentPosition }';
}