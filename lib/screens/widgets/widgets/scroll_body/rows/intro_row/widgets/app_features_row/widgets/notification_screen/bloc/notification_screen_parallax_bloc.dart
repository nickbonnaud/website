import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'notification_screen_parallax_event.dart';
part 'notification_screen_parallax_state.dart';

class NotificationScreenParallaxBloc extends Bloc<NotificationScreenParallaxEvent, NotificationScreenParallaxState> {
  NotificationScreenParallaxBloc() : super(NotificationScreenParallaxState.initial()) {
    _eventHandler();
  }

  void _eventHandler() {
    on<ImageVisibilityChanged>((event, emit) => _mapImageVisibilityChangedToState(event: event, emit: emit));
    on<CurrentPositionChanged>((event, emit) => _mapCurrentPositionChangedToState(event: event, emit: emit));
  }

  void _mapImageVisibilityChangedToState({required ImageVisibilityChanged event, required Emitter<NotificationScreenParallaxState> emit}) {
    emit(state.update(
      isImageVisible: event.isImageVisible,
      entryPosition: event.entryPosition,
      resetEntry: event.entryPosition == null
    ));
  }

  void _mapCurrentPositionChangedToState({required CurrentPositionChanged event, required Emitter<NotificationScreenParallaxState> emit}) {
    emit(state.update(currentPosition: event.currentPosition));
  }
}
