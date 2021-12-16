import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'integration_row_parallax_event.dart';
part 'integration_row_parallax_state.dart';

class IntegrationRowParallaxBloc extends Bloc<IntegrationRowParallaxEvent, IntegrationRowParallaxState> {
  IntegrationRowParallaxBloc() : super(IntegrationRowParallaxState.initial()) {
    _eventHandler();
  }

  double get parallaxOffset => (state.entryPosition! - state.currentPosition!) * .25;

  void _eventHandler() {
    on<ImageVisibilityChanged>((event, emit) => _mapImageVisibilityChangedToState(event: event, emit: emit));
    on<CurrentPositionChanged>((event, emit) => _mapCurrentPositionChangedToState(event: event, emit: emit));
  }

  void _mapImageVisibilityChangedToState({required ImageVisibilityChanged event, required Emitter<IntegrationRowParallaxState> emit}) {
    emit(state.update(isImageVisible: event.isImageVisible, entryPosition: event.entryPosition));
  }

  void _mapCurrentPositionChangedToState({required CurrentPositionChanged event, required Emitter<IntegrationRowParallaxState> emit}) {
    emit(state.update(currentPosition: event.currentPosition));
  }
}
