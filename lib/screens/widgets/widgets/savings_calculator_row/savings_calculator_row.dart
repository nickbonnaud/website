import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/resources/helpers/column_spacer.dart';
import 'package:website/resources/helpers/row_spacer.dart';

import 'widgets/bloc/savings_calculator_bloc.dart';
import 'widgets/savings_calculator.dart';

class SavingsCalculatorRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const SavingsCalculatorRow({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xfff5f5f3)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: ColumnSpacer(
            spacer: const SizedBox(height: 20),
            children: [
              const Text(
                'How much Nova Pay saves you',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              RowSpacer(
                spacer: const SizedBox(width: 50),
                children: [
                  const Expanded(
                    child: Text(
                      'Total Savings',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      )
                    ),
                  ),
                  Expanded(
                    child: BlocProvider<SavingsCalculatorBloc>(
                      create: (_) => SavingsCalculatorBloc(),
                      child: SavingsCalculator(businessListViewKey: _businessListViewKey, scrollController: _scrollController),
                    ),
                  ),
                ]
              ),
              const Text(
                'Based on 10,000 transactions with an average sale of \$20 at 2.9% per transaction + 10¢',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}