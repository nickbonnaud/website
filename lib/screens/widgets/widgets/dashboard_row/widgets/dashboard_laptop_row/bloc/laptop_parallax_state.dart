part of 'laptop_parallax_bloc.dart';

@immutable
class LaptopParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const LaptopParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory LaptopParallaxState.initial() {
    return const LaptopParallaxState(isImageVisible: false);
  }

  LaptopParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return LaptopParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'LaptopParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
