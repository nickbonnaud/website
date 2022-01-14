part of 'employee_screen_parallax_bloc.dart';

abstract class EmployeeScreenParallaxEvent extends Equatable {
  const EmployeeScreenParallaxEvent();

  @override
  List<Object?> get props => [];
}

class ImageVisibilityChanged extends EmployeeScreenParallaxEvent {
  final bool isImageVisible;
  final double? entryPosition;

  const ImageVisibilityChanged({required this.isImageVisible, required this.entryPosition});

  @override
  List<Object?> get props => [isImageVisible, entryPosition];

  @override
  String toString() => 'ImageVisibilityChanged { isImageVisible: $isImageVisible, entryPosition: $entryPosition }';
}

class CurrentPositionChanged extends EmployeeScreenParallaxEvent {
  final double currentPosition;

  const CurrentPositionChanged({required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];

  @override
  String toString() => 'CurrentPositionChanged { currentPosition: $currentPosition }';
}