part of 'operation_row_parallax_bloc.dart';

@immutable
class OperationRowParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const OperationRowParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory OperationRowParallaxState.initial() {
    return const OperationRowParallaxState(isImageVisible: false);
  }

  OperationRowParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return OperationRowParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'OperationRowParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
