part of 'notification_screen_parallax_bloc.dart';

@immutable
class NotificationScreenParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  const NotificationScreenParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory NotificationScreenParallaxState.initial() {
    return const NotificationScreenParallaxState(isImageVisible: false);
  }

  NotificationScreenParallaxState update({bool? isImageVisible, double? currentPosition, double? entryPosition}) {
    return NotificationScreenParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'NotificationScreenParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
