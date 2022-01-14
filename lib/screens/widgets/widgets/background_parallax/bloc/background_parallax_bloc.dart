import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'background_parallax_event.dart';
part 'background_parallax_state.dart';

class BackgroundParallaxBloc extends Bloc<BackgroundParallaxEvent, BackgroundParallaxState> {
  static const firstImage = '/assets/landscape/coffee_shop.jpg';
  static const secondImage = '/assets/landscape/restaurant.jpg';
  static const thirdImage = '/assets/landscape/bar.jpg';
  static const fourthImage = '/assets/landscape/sports_bar.jpg';
  
  BackgroundParallaxBloc({
    required String initialImage,
    required double constantTopMargin,
    required double constantEntryDistanceFromTop
  }) : super(BackgroundParallaxState.initial(initialImage: initialImage, constantTopMargin: constantTopMargin, constantEntryDistanceFromTop: constantEntryDistanceFromTop)) {
    _eventHandler();
  }

  void _eventHandler() {
    on<ScrollChanged>((event, emit) => _mapScrollChangedToState(event: event, emit: emit));
    on<BackgroundImageChanged>((event, emit) => _mapBackgroundImageChangedToState(event: event, emit: emit));
  }

  void _mapScrollChangedToState({required ScrollChanged event, required Emitter<BackgroundParallaxState> emit}) {
    emit(state.update(absolutePositionY: event.absolutePositionY));
  }

  void _mapBackgroundImageChangedToState({required BackgroundImageChanged event, required Emitter<BackgroundParallaxState> emit}) {
    emit(state.update(
      currentImage: event.image,
      constantEntryPositionY: event.constantEntryPositionY,
      constantEntryDistanceFromTop: event.constantEntryDistanceFromTop
    ));
  }
}
