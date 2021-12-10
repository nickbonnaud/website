part of 'business_screen_parallax_bloc.dart';

@immutable
class BusinessScreenParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const BusinessScreenParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory BusinessScreenParallaxState.initial() {
    return const BusinessScreenParallaxState(isImageVisible: false);
  }

  BusinessScreenParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return BusinessScreenParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'BusinessScreenParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
