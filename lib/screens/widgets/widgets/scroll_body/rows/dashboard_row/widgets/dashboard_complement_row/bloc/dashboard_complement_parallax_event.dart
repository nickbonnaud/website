part of 'dashboard_complement_parallax_bloc.dart';

abstract class DashboardComplementParallaxEvent extends Equatable {
  const DashboardComplementParallaxEvent();

  @override
  List<Object?> get props => [];
}

class ImageVisibilityChanged extends DashboardComplementParallaxEvent {
  final bool isImageVisible;
  final double? entryPosition;

  const ImageVisibilityChanged({required this.isImageVisible, required this.entryPosition});

  @override
  List<Object?> get props => [isImageVisible, entryPosition];

  @override
  String toString() => 'ImageVisibilityChanged { isImageVisible: $isImageVisible, entryPosition: $entryPosition }';
}

class CurrentPositionChanged extends DashboardComplementParallaxEvent {
  final double currentPosition;

  const CurrentPositionChanged({required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];

  @override
  String toString() => 'CurrentPositionChanged { currentPosition: $currentPosition }';
}