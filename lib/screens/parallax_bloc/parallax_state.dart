part of 'parallax_bloc.dart';

@immutable
class ParallaxState extends Equatable {
  final double offset;

  const ParallaxState({required this.offset});

  factory ParallaxState.initial() {
    return const ParallaxState(offset: 0);
  }

  ParallaxState update({required double offset}) {
    return ParallaxState(offset: offset);
  }

  @override
  List<Object?> get props => [offset];

  @override
  String toString() => 'ParallaxState { offset: $offset }';
}

