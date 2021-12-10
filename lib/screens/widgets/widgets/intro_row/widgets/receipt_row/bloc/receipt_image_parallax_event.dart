part of 'receipt_image_parallax_bloc.dart';

abstract class ReceiptImageParallaxEvent extends Equatable {
  const ReceiptImageParallaxEvent();

  @override
  List<Object?> get props => [];
}

class ImageVisibilityChanged extends ReceiptImageParallaxEvent {
  final bool isImageVisible;
  final double? entryPosition;

  const ImageVisibilityChanged({required this.isImageVisible, required this.entryPosition});

  @override
  List<Object?> get props => [isImageVisible, entryPosition];

  @override
  String toString() => 'ImageVisibilityChanged { isImageVisible: $isImageVisible, entryPosition: $entryPosition }';
}

class CurrentPositionChanged extends ReceiptImageParallaxEvent {
  final double currentPosition;

  const CurrentPositionChanged({required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];

  @override
  String toString() => 'CurrentPositionChanged { currentPosition: $currentPosition }';
}