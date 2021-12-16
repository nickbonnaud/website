import 'package:bloc/bloc.dart';

class GetStartedButtonCubit extends Cubit<bool> {
  GetStartedButtonCubit() : super(false);

  void hoverStatusChanged({required bool isFocused}) => emit(isFocused);
}
