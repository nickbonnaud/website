part of 'employee_screen_parallax_bloc.dart';

@immutable
class EmployeeScreenParallaxState extends Equatable {
  final bool isImageVisible;
  final double? currentPosition;
  final double? entryPosition;

  double get parallaxOffset => (entryPosition! - currentPosition!) * .2;
  
  const EmployeeScreenParallaxState({
    required this.isImageVisible,
    this.currentPosition,
    this.entryPosition
  });

  factory EmployeeScreenParallaxState.initial() {
    return const EmployeeScreenParallaxState(isImageVisible: false);
  }

  EmployeeScreenParallaxState update({
    bool? isImageVisible,
    double? currentPosition,
    double? entryPosition,
    bool resetEntry = false
    }) {
    return EmployeeScreenParallaxState(
      isImageVisible: isImageVisible ?? this.isImageVisible,
      currentPosition: currentPosition ?? this.currentPosition,
      entryPosition: resetEntry ? null : entryPosition ?? this.entryPosition
    );
  }

  @override
  List<Object?> get props => [isImageVisible, currentPosition, entryPosition];

  @override
  String toString() => 'EmployeeScreenParallaxState { isImageVisible: $isImageVisible, currentPosition: $currentPosition, entryPosition: $entryPosition }';
}
