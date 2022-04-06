import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'key_holder_state.dart';

class KeyHolderCubit extends Cubit<KeyHolderState> {
  KeyHolderCubit() : super(KeyHolderState.initial());
}
