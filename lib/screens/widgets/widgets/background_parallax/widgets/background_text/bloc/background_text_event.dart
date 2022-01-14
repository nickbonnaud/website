part of 'background_text_bloc.dart';

abstract class BackgroundTextEvent extends Equatable {
  const BackgroundTextEvent();

  @override
  List<Object> get props => [];
}

class ImageChanged extends BackgroundTextEvent {
  final String newImage;

  const ImageChanged({required this.newImage});

  @override
  List<Object> get props => [newImage];

  @override
  String toString() => 'ImageChanged { newImage: $newImage }';
}

class PercentDistanceChanged extends BackgroundTextEvent {
  final double percentDistance;

  const PercentDistanceChanged({required this.percentDistance});

  @override
  List<Object> get props => [percentDistance];

  @override
  String toString() => 'PercentDistanceChanged { percentDistance: $percentDistance }';
}