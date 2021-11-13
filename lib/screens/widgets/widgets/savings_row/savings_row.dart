import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/savings_calculator_row/savings_calculator_form/bloc/savings_calculator_form_bloc.dart';
import 'widgets/savings_calculator_row/savings_calculator_row.dart';
import 'widgets/signup_now_row/signup_now_row.dart';

class SavingsRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const SavingsRow({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;
  
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f3),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.7),
          spreadRadius: 15,
          blurRadius: 5,
          offset: const Offset(0, 3))
        ]
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: BlocProvider<SavingsCalculatorFormBloc>(
                create: (_) => SavingsCalculatorFormBloc(),
                child: SavingsCalculatorRow(),
              ),
            ),
            Expanded(
              child: SignupNowRow(
                businessListViewKey: _businessListViewKey,
                scrollController: _scrollController,
              )
            ),
          ],
        ),
      ),
    );
  }
}