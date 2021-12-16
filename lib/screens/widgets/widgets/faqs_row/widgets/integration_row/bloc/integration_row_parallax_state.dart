part of 'integration_row_parallax_bloc.dart';

@immutable
class IntegrationRowParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const IntegrationRowParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory IntegrationRowParallaxState.initial() {
    return const IntegrationRowParallaxState(isImageVisible: false);
  }

  IntegrationRowParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return IntegrationRowParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'IntegrationRowParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
