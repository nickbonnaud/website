part of 'savings_explanation_bloc.dart';

@immutable
class SavingsExplanationState extends Equatable {
  final bool brainPlayed;
  final bool registerPlayed;
  final bool invoicePlayed;
  final bool piggyBankPlayed;
  final bool freePlayed;
  final bool coinsPlayed;

  const SavingsExplanationState({
    required this.brainPlayed,
    required this.registerPlayed,
    required this.invoicePlayed,
    required this.piggyBankPlayed,
    required this.freePlayed,
    required this.coinsPlayed
  });

  factory SavingsExplanationState.initial() {
    return const SavingsExplanationState(
      brainPlayed: false,
      registerPlayed: false,
      invoicePlayed: false,
      piggyBankPlayed: false,
      freePlayed: false,
      coinsPlayed: false
    );
  }

  SavingsExplanationState update({
    bool? brainPlayed,
    bool? registerPlayed,
    bool? invoicePlayed,
    bool? piggyBankPlayed,
    bool? freePlayed,
    bool? coinsPlayed
  }) {
    return SavingsExplanationState(
      brainPlayed: brainPlayed ?? this.brainPlayed,
      registerPlayed: registerPlayed ?? this.registerPlayed,
      invoicePlayed: invoicePlayed ?? this.invoicePlayed,
      piggyBankPlayed: piggyBankPlayed ?? this.piggyBankPlayed,
      freePlayed: freePlayed ?? this.freePlayed,
      coinsPlayed: coinsPlayed ?? this.coinsPlayed
    );
  }

  @override
  List<Object> get props => [
    brainPlayed,
    registerPlayed,
    invoicePlayed,
    piggyBankPlayed,
    freePlayed,
    coinsPlayed
  ];

  @override
  String toString() => '''SavingsExplanationState {
    brainPlayed: $brainPlayed,
    registerPlayed: $registerPlayed,
    invoicePlayed: $invoicePlayed,
    piggyBankPlayed: $piggyBankPlayed,
    freePlayed: $freePlayed,
    coinsPlayed: $coinsPlayed
  }''';
}

