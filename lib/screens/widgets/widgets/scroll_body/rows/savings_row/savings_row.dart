import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/pricing_row/pricing_row.dart';
import 'widgets/savings_calculator_row/savings_calculator_form/bloc/savings_calculator_form_bloc.dart';
import 'widgets/savings_calculator_row/savings_calculator_row.dart';
import 'widgets/savings_explanation_row/bloc/savings_explanation_bloc.dart';
import 'widgets/savings_explanation_row/savings_explanation_row.dart';
import 'widgets/signup_now_row/cubit/signup_now_row_cubit.dart';
import 'widgets/signup_now_row/signup_now_row.dart';

class SavingsRow extends StatelessWidget {

  const SavingsRow({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.7),
          spreadRadius: 15,
          blurRadius: 5,
          offset: const Offset(0, 3))
        ]
      ),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          BlocProvider<SignupNowRowCubit>(
            create: (_) => SignupNowRowCubit(),
            child: const SignupNowRow(),
          ),
          SizedBox(height: 30.h),
          const PricingRow(),
          SizedBox(height: 60.h),
          BlocProvider<SavingsExplanationBloc>(
            create: (_) => SavingsExplanationBloc(),
            child: const SavingsExplanationRow()
          ),
          BlocProvider<SavingsCalculatorFormBloc>(
            create: (_) => SavingsCalculatorFormBloc(),
            child: const SavingsCalculatorRow(),
          ),
        ],
      ),
    );
  }
}