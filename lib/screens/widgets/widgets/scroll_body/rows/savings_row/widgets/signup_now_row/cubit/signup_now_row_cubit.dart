import 'package:bloc/bloc.dart';

class SignupNowRowCubit extends Cubit<bool> {
  SignupNowRowCubit() : super(false);

  void hoverStatusChanged({required bool isHovered}) => emit(isHovered);
}
