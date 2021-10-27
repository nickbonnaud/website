import 'package:bloc/bloc.dart';

class HomeScreenCubit extends Cubit<double> {
  HomeScreenCubit() : super(0);

  void scrollUpdated({required double offset}) => emit(offset);
}
