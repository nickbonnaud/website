part of 'results_row_parallax_bloc.dart';

@immutable
class ResultsRowParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const ResultsRowParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory ResultsRowParallaxState.initial() {
    return const ResultsRowParallaxState(isImageVisible: false);
  }

  ResultsRowParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return ResultsRowParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'ResultsRowParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
