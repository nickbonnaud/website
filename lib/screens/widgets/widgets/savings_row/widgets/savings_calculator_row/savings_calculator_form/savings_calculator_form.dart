import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/currency.dart';
import 'package:website/resources/helpers/input_formatters/cents_formatter.dart';
import 'package:website/resources/helpers/input_formatters/dollar_formatter.dart';
import 'package:website/resources/helpers/input_formatters/formatter.dart';
import 'package:website/resources/helpers/input_formatters/percent_formatter.dart';
import 'package:website/resources/helpers/input_formatters/thousands_formatter.dart';
import 'package:website/resources/helpers/row_spacer.dart';

import 'bloc/savings_calculator_form_bloc.dart';

class SavingsCalculatorForm extends StatefulWidget {

  @override
  State<SavingsCalculatorForm> createState() => _SavingsCalculatorFormState();
}

class _SavingsCalculatorFormState extends State<SavingsCalculatorForm> {
  final FocusNode _focusNode = FocusNode();
  
  late TextEditingController _controller;
  late Formatter _inputFormatter;

  late SavingsCalculatorFormBloc _formBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _inputFormatter = ThousandsFormatter();
    _formBloc = BlocProvider.of<SavingsCalculatorFormBloc>(context);

    _controller.addListener(_fieldChanged);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingsCalculatorFormBloc, SavingsCalculatorFormState>(
      builder: (context, state) => _body(state: state));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _formBloc.close();
    super.dispose();
  }
  
  Widget _body({required SavingsCalculatorFormState state}) {
    if (state.formSubmitted) {
      return Row(
        children: [
          Expanded(
            flex: 7,
            child: RowSpacer(
              spacer: SizedBox(width: 20.w),
              children: [
                const Text(
                  "Your Total Savings: ",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
                ),
                Text(
                  Currency.create(cents: state.totalSavings),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
                ),
              ],
            )
          ),
          Expanded(
            flex: 3,
            child: _resetButton()
          )
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 7,
          child: _formField(state: state)
        ),
        Expanded(
          flex: 3,
          child: _submitButton(state: state)
        )
      ],
    );
  }
  
  Widget _resetButton() {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: 125.w,
        height: 125.w
      ),
      child: ElevatedButton(
        onPressed: () => _formBloc.add(ResetForm()),
        child: Text(
          "Reset",
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 20,
          shape: const CircleBorder()
        )
      )
    );
  }
  
  Widget _submitButton({required SavingsCalculatorFormState state}) {
    if (!state.isFieldVisible) {
      return ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: 125.w,
          height: 125.w
        ),
        child: ElevatedButton(
          onPressed: () => _formBloc.add(FieldVisibilityChanged(fieldVisible: !state.isFieldVisible)),
          child: Text(
            "Start",
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 20,
            shape: const CircleBorder()
          )
        )
      );
    }
    
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: 125.w,
        height: 125.w
      ),
      child: ElevatedButton(
        onPressed: state.isFieldValid && _controller.text.isNotEmpty
          ? () => _submit()
          : null,
        child: Text(
          _buttonText(state: state),
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 20,
          shape: const CircleBorder()
        )
      )
    );
  }
  
  Widget _formField({required SavingsCalculatorFormState state}) {
    if (!state.isFieldVisible) {
      return const Text(
        "Calculate how much Nova can save you!",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black
        )
      );
    }
    
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      onFieldSubmitted: (_) => _submit(),
      decoration: InputDecoration(
        hintText: _hintText(state: state),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
          color: Colors.black26
        )
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32
      ),
      validator: (_) => !state.isFieldValid && _controller.text.isNotEmpty
        ? "Please only use digits!"
        : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [_inputFormatter],
    );
  }
  
  void _fieldChanged() {
    if (!_formBloc.state.numberTransactionsSubmitted) {
      _formBloc.add(NumberTransactionsChanged(numberTransactions: _inputFormatter.unMasked()));
    } else if (!_formBloc.state.percentFeeSubmitted) {
      _formBloc.add(PercentFeeChanged(percentFee: _inputFormatter.unMasked()));
    } else if (!_formBloc.state.setFeeSubmitted) {
      _formBloc.add(SetFeeChanged(setFee: _inputFormatter.unMasked()));
    } else {
      _formBloc.add(AverageTotalChanged(averageTotal: _inputFormatter.unMasked()));
    }
  }
  
  void _submit() {
    if (!_formBloc.state.numberTransactionsSubmitted) {
      _formBloc.add(NumberTransactionsSubmitted(numberTransactions: _inputFormatter.unMasked()));
      _controller.clear();
      _inputFormatter = PercentFormatter();
    } else if (!_formBloc.state.percentFeeSubmitted) {
      _formBloc.add(PercentFeeSubmitted(percentFee: _inputFormatter.unMasked()));
      _controller.clear();
      _inputFormatter = CentsFormatter();
    } else if (!_formBloc.state.setFeeSubmitted) {
      _formBloc.add(SetFeeSubmitted(setFee: _inputFormatter.unMasked()));
      _controller.clear();
      _inputFormatter = DollarFormatter();
    } else {
      _formBloc.add(AverageTotalSubmitted(averageTotal: _inputFormatter.unMasked()));
      _controller.clear();
      _inputFormatter = ThousandsFormatter();
    }
  }
  
  String _hintText({required SavingsCalculatorFormState state}) {
    if (!state.numberTransactionsSubmitted) {
      return "20,000";
    } else if (!state.percentFeeSubmitted) {
      return "2.9%";
    } else if (!state.setFeeSubmitted) {
      return "10¢";
    } else {
      return "\$20";
    }
  }

  String _buttonText({required SavingsCalculatorFormState state}) {
    if (!state.setFeeSubmitted) {
      return "Next";
    } else {
      return "Finish";
    }
  }
}