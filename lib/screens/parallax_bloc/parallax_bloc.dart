import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'parallax_event.dart';
part 'parallax_state.dart';

class ParallaxBloc extends Bloc<ParallaxEvent, ParallaxState> {
  
  ParallaxBloc() : super(ParallaxState.initial()) {
    _eventHandler();
  }

  void _eventHandler() {
    on<ScrollUpdated>((event, emit) => _mapScrollUpdatedToState(event: event, emit: emit));
  }

  void _mapScrollUpdatedToState({required ScrollUpdated event, required Emitter emit}) {
    emit(state.update(offset: event.offset));
  }
}
