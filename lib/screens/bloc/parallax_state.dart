part of 'parallax_bloc.dart';

@immutable
class ParallaxState extends Equatable {
  final double offset;
  final double offsetAdjustment;
  final String currentBackground;

  const ParallaxState({
    required this.offset,
    required this.offsetAdjustment,
    required this.currentBackground
  });

  factory ParallaxState.initial({required String initialBackground}) {
    return ParallaxState(offset: 0, offsetAdjustment: 0, currentBackground: initialBackground);
  }

  ParallaxState update({double? offset, double? offsetAdjustment, String? currentBackground}) {
    return ParallaxState(
      offset: offset ?? this.offset,
      offsetAdjustment: offsetAdjustment ?? this.offsetAdjustment,
      currentBackground: currentBackground ?? this.currentBackground
    );
  }

  @override
  List<Object?> get props => [offset, offsetAdjustment, currentBackground];

  @override
  String toString() => 'ParallaxState { offset: $offset, offsetAdjustment: $offsetAdjustment, currentBackground: $currentBackground }';
}

