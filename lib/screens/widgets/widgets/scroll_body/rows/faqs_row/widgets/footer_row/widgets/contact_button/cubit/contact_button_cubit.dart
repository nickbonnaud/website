import 'package:bloc/bloc.dart';

class ContactButtonCubit extends Cubit<bool> {
  ContactButtonCubit() : super(false);

  void hoverStatusChanged({required bool isFocused}) => emit(isFocused);
}
