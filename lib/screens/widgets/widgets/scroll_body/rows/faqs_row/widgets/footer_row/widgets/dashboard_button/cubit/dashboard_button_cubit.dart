import 'package:bloc/bloc.dart';

class DashboardButtonCubit extends Cubit<bool> {
  DashboardButtonCubit() : super(false);

  void hoverStatusChanged({required bool isFocused}) => emit(isFocused);
}
