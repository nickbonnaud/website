part of 'dashboard_complement_parallax_bloc.dart';

@immutable
class DashboardComplementParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const DashboardComplementParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory DashboardComplementParallaxState.initial() {
    return const DashboardComplementParallaxState(isImageVisible: false);
  }

  DashboardComplementParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return DashboardComplementParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'DashboardComplementParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
