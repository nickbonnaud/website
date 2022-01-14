part of 'operation_row_parallax_bloc.dart';

@immutable
class OperationRowParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  double get parallaxOffset => (entryPosition! - currentPosition!) * .15;
  
  const OperationRowParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory OperationRowParallaxState.initial() {
    return const OperationRowParallaxState(isImageVisible: false);
  }

  OperationRowParallaxState update({
    bool? isImageVisible,
    double? currentPosition,
    double? entryPosition,
    bool resetEntry = false
  }) {
    return OperationRowParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: resetEntry ? null : entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'OperationRowParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
