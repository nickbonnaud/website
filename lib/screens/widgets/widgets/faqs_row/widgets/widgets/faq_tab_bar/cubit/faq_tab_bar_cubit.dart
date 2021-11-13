import 'package:bloc/bloc.dart';

class FaqTabBarCubit extends Cubit<int> {
  FaqTabBarCubit() : super(0);

  void indexChanged({required int index}) => emit(index);

  int currentIndex() {
    return state;
  }
}
