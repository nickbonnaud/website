import 'package:bloc/bloc.dart';

class ReadyButtonCubit extends Cubit<bool> {
  ReadyButtonCubit() : super(false);

  void hoverStatusChanged({required bool isFocused}) => emit(isFocused);
}
