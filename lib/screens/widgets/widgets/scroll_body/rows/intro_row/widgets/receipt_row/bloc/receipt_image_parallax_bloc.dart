import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'receipt_image_parallax_event.dart';
part 'receipt_image_parallax_state.dart';

class ReceiptImageParallaxBloc extends Bloc<ReceiptImageParallaxEvent, ReceiptImageParallaxState> {
  ReceiptImageParallaxBloc() : super(ReceiptImageParallaxState.initial()) {
    _eventHandler();
  }

  void _eventHandler() {
    on<ImageVisibilityChanged>((event, emit) => _mapImageVisibilityChangedToState(event: event, emit: emit));
    on<CurrentPositionChanged>((event, emit) => _mapCurrentPositionChangedToState(event: event, emit: emit));
  }

  void _mapImageVisibilityChangedToState({required ImageVisibilityChanged event, required Emitter<ReceiptImageParallaxState> emit}) {
    emit(state.update(
      isImageVisible: event.isImageVisible,
      entryPosition: event.entryPosition,
      resetEntry: event.entryPosition == null
    ));
  }

  void _mapCurrentPositionChangedToState({required CurrentPositionChanged event, required Emitter<ReceiptImageParallaxState> emit}) {
    emit(state.update(currentPosition: event.currentPosition));
  }
}
