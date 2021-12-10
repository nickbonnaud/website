import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/column_spacer.dart';

import 'savings_calculator_form/bloc/savings_calculator_form_bloc.dart';
import 'savings_calculator_form/savings_calculator_form.dart';
import 'title/bloc/calculator_title_bloc.dart';
import 'title/calculator_title_enter.dart';
import 'title/calculator_title_exit.dart';

class SavingsCalculatorRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 76.w, vertical: 40.h),
        child: BlocBuilder<SavingsCalculatorFormBloc, SavingsCalculatorFormState>(
        builder: (context, state) {
          return ColumnSpacer(
            spacer: const SizedBox(height: 20),
            children: [
              if (state.isFieldVisible && !state.formSubmitted) 
                BlocProvider<CalculatorTitleBloc>(
                  create: (_) => CalculatorTitleBloc(savingsCalculatorFormBloc: BlocProvider.of<SavingsCalculatorFormBloc>(context)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CalculatorTitleExit(),
                      CalculatorTitleEnter()
                    ],
                  ),
                ),
              SavingsCalculatorForm(),
            ]
          );
        }
      ),
    );
  }
}