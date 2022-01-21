import 'package:bloc/bloc.dart';

class ViewAppButtonCubit extends Cubit<bool> {
  ViewAppButtonCubit() : super(false);

  void hoverStatusChanged({required bool isFocused}) => emit(isFocused);
}
