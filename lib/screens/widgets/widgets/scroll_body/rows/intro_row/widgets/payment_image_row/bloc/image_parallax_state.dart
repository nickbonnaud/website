part of 'image_parallax_bloc.dart';

@immutable
class ImageParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  double get parallaxOffset => (entryPosition! - currentPosition!) * .1;
  
  const ImageParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory ImageParallaxState.initial() {
    return const ImageParallaxState(isImageVisible: false);
  }

  ImageParallaxState update({
    bool? isImageVisible,
    double? currentPosition,
    double? entryPosition,
    bool resetEntry = false
  }) {
    return ImageParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: resetEntry ? null : entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'ImageParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
