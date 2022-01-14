part of 'receipt_image_parallax_bloc.dart';

@immutable
class ReceiptImageParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  double get parallaxOffset => (entryPosition! - currentPosition!) * .25;
  
  const ReceiptImageParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory ReceiptImageParallaxState.initial() {
    return const ReceiptImageParallaxState(isImageVisible: false);
  }

  ReceiptImageParallaxState update({
    bool? isImageVisible,
    double? currentPosition,
    double? entryPosition,
    bool resetEntry = false
  }) {
    return ReceiptImageParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: resetEntry ? null : entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'ReceiptImageParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
