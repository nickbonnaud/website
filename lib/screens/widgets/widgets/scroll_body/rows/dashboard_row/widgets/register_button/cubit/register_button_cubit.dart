import 'package:bloc/bloc.dart';

class RegisterButtonCubit extends Cubit<bool> {
  RegisterButtonCubit() : super(false);

  void hoverStatusChanged({required bool isFocused}) => emit(isFocused);
}
