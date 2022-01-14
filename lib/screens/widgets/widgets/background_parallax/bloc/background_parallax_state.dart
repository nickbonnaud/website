part of 'background_parallax_bloc.dart';

@immutable
class BackgroundParallaxState extends Equatable {
  final String currentImage;
  final double constantEntryPositionY;
  final double constantTopMargin;
  final double constantEntryDistanceFromTop;
  final double absolutePositionY;

  double get _distanceTraveled => absolutePositionY - constantEntryPositionY;
  double get percentDistanceTraveled => 1 - (((2 * constantEntryDistanceFromTop ) - _distanceTraveled) / (2 * constantEntryDistanceFromTop));
  double get topOffset => -constantTopMargin - constantTopMargin * percentDistanceTraveled;

  
  const BackgroundParallaxState({
    required this.currentImage,
    required this.constantEntryPositionY,
    required this.constantTopMargin,
    required this.constantEntryDistanceFromTop,
    required this.absolutePositionY,
  });

  factory BackgroundParallaxState.initial({required String initialImage, required double constantTopMargin, required double constantEntryDistanceFromTop}) {
    return BackgroundParallaxState(
      currentImage: initialImage,
      constantEntryPositionY: 0,
      constantTopMargin: constantTopMargin,
      constantEntryDistanceFromTop: constantEntryDistanceFromTop,
      absolutePositionY: 0,
    );
  }

  BackgroundParallaxState update({
    String? currentImage,
    double? constantEntryPositionY,
    double? constantTopMargin,
    double? constantEntryDistanceFromTop,
    double? absolutePositionY
  }) {
    return BackgroundParallaxState(
      currentImage: currentImage ?? this.currentImage,
      constantEntryPositionY: constantEntryPositionY ?? this.constantEntryPositionY,
      constantTopMargin: constantTopMargin ?? this.constantTopMargin,
      constantEntryDistanceFromTop: constantEntryDistanceFromTop ?? this.constantEntryDistanceFromTop,
      absolutePositionY: absolutePositionY ?? this.absolutePositionY,
    );
  }

  @override
  List<Object> get props => [
    currentImage,
    constantEntryPositionY,
    constantTopMargin,
    constantEntryDistanceFromTop,
    absolutePositionY
  ];

  @override
  String toString() => '''BackgroundParallaxState {
    currentImage: $currentImage,
    constantEntryPositionY: $constantEntryPositionY,
    constantTopMargin: $constantTopMargin,
    constantEntryDistanceFromTop: $constantEntryDistanceFromTop,
    absolutePositionY: $absolutePositionY
  }''';
}
