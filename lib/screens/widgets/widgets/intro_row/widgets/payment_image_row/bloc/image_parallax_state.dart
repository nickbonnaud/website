part of 'image_parallax_bloc.dart';

@immutable
class ImageParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const ImageParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory ImageParallaxState.initial() {
    return const ImageParallaxState(isImageVisible: false);
  }

  ImageParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return ImageParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'ImageParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
