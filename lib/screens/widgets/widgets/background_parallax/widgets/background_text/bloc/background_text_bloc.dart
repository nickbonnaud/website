import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:website/screens/widgets/widgets/background_parallax/bloc/background_parallax_bloc.dart';

part 'background_text_event.dart';
part 'background_text_state.dart';

class BackgroundTextBloc extends Bloc<BackgroundTextEvent, BackgroundTextState> {
  late StreamSubscription _backgroundParallaxBlocSubScription;
  
  BackgroundTextBloc({required BackgroundParallaxBloc backgroundParallaxBloc})
    : super(BackgroundTextState.initial(initialImage: backgroundParallaxBloc.state.currentImage)) {
      _eventHandler();

      _backgroundParallaxBlocSubScription = backgroundParallaxBloc.stream.listen((BackgroundParallaxState backgroundParallaxState) { 
        if (backgroundParallaxState.currentImage != state.currentImage) {
          add(ImageChanged(newImage: backgroundParallaxState.currentImage));
        }

        if (backgroundParallaxBloc.state.percentDistanceTraveled != state.percentDistance) {
          add(PercentDistanceChanged(percentDistance: backgroundParallaxBloc.state.percentDistanceTraveled));
        }
      });
  }

  @override
  Future<void> close() {
    _backgroundParallaxBlocSubScription.cancel();
    return super.close();
  }

  void _eventHandler() {
    on<ImageChanged>((event, emit) => _mapImageChangedToState(event: event, emit: emit));
    on<PercentDistanceChanged>((event, emit) => _mapPercentDistanceChangedToState(event: event, emit: emit));
  }
  
  void _mapImageChangedToState({required ImageChanged event, required Emitter<BackgroundTextState> emit}) {
    emit(state.update(currentImage: event.newImage, previousImage: state.currentImage));
  }

  void _mapPercentDistanceChangedToState({required PercentDistanceChanged event, required Emitter<BackgroundTextState> emit}) {
    emit(state.update(percentDistance: event.percentDistance));
  }
}
