import 'package:bloc/bloc.dart';

class TypicalSavingsTitleCubit extends Cubit<double> {
  TypicalSavingsTitleCubit() : super(0);

  void scroll({required double position}) {
    final double opacity = (position / 100);
    if (opacity > 1) {
      emit(1);
    } else if (opacity < 0) {
      emit(0);
    } else {
      emit(opacity);
    }
  }
}
