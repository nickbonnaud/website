part of 'laptop_parallax_bloc.dart';

@immutable
class LaptopParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  double get parallaxOffset => (entryPosition! - currentPosition!) * .15;

  const LaptopParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory LaptopParallaxState.initial() {
    return const LaptopParallaxState(isImageVisible: false);
  }

  LaptopParallaxState update({
    bool? isImageVisible,
    double? currentPosition,
    double? entryPosition,
    bool resetEntry = false
  }) {
    return LaptopParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: resetEntry ? null : entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'LaptopParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
