import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'parallax_event.dart';
part 'parallax_state.dart';

class ParallaxBloc extends Bloc<ParallaxEvent, ParallaxState> {
  static const firstImage = '/assets/landscape/coffee_shop.jpg';
  static const secondImage = '/assets/landscape/restaurant.jpg';
  static const thirdImage = '/assets/landscape/bar.jpg';
  static const fourthImage = '/assets/landscape/sports_bar.jpg';
  
  ParallaxBloc({required String initialBackground})
    : super(ParallaxState.initial(initialBackground: initialBackground)) {
      _eventHandler();
  }

  void _eventHandler() {
    on<ScrollUpdated>((event, emit) => _mapScrollUpdatedToState(event: event, emit: emit));
    on<BackgroundChanged>((event, emit) => _mapBackgroundChangedToState(event: event, emit: emit));
  }

  void _mapScrollUpdatedToState({required ScrollUpdated event, required Emitter emit}) {
    emit(state.update(offset: event.offset));
  }

  void _mapBackgroundChangedToState({required BackgroundChanged event, required Emitter emit}) {
    emit(state.update(offset: event.currentOffset, offsetAdjustment: event.offsetAdjustment, currentBackground: event.newBackground));
  }
}
