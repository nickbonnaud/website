import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class SignupButtonCubit extends Cubit<bool> {
  SignupButtonCubit() : super(false);

  void hoverStatusChanged({required bool isHovered}) => emit(isHovered);
}
