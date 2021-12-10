part of 'sales_screen_parallax_bloc.dart';

@immutable
class SalesScreenParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const SalesScreenParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory SalesScreenParallaxState.initial() {
    return const SalesScreenParallaxState(isImageVisible: false);
  }

  SalesScreenParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return SalesScreenParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'SalesScreenParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}

