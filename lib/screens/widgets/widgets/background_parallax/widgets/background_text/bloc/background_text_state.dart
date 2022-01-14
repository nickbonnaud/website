part of 'background_text_bloc.dart';

@immutable
class BackgroundTextState extends Equatable {
  final String currentImage;
  final String previousImage;
  final double percentDistance;

  const BackgroundTextState({
    required this.currentImage,
    required this.previousImage,
    required this.percentDistance
  });

  factory BackgroundTextState.initial({required String initialImage}) {
    return BackgroundTextState(currentImage: initialImage, previousImage: initialImage, percentDistance: 0);
  }

  BackgroundTextState update({String? currentImage, String? previousImage, double? percentDistance}) {
    return BackgroundTextState(
      currentImage: currentImage ?? this.currentImage,
      previousImage: previousImage ?? this.previousImage,
      percentDistance: percentDistance ?? this.percentDistance
    );
  }
  
  @override
  List<Object> get props => [currentImage, previousImage, percentDistance];

  @override
  String toString() => 'BackgroundTextState { currentImage: $currentImage, previousImage: $previousImage, percentDistance: $percentDistance }';
}

