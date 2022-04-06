import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/currency.dart';
import 'package:website/resources/input_formatters/cents_formatter.dart';
import 'package:website/resources/input_formatters/dollar_formatter.dart';
import 'package:website/resources/input_formatters/formatter.dart';
import 'package:website/resources/input_formatters/percent_formatter.dart';
import 'package:website/resources/input_formatters/thousands_formatter.dart';

import 'bloc/savings_calculator_form_bloc.dart';

class SavingsCalculatorForm extends StatefulWidget {

  const SavingsCalculatorForm({Key? key})
    : super(key: key);
  
  @override
  State<SavingsCalculatorForm> createState() => _SavingsCalculatorFormState();
}

class _SavingsCalculatorFormState extends State<SavingsCalculatorForm> {
  final FocusNode _focusNode = FocusNode();
  
  late TextEditingController _controller;
  late Formatter _inputFormatter;
  late ConfettiController _confettiController;

  late SavingsCalculatorFormBloc _formBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _inputFormatter = ThousandsFormatter();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _formBloc = BlocProvider.of<SavingsCalculatorFormBloc>(context);

    _controller.addListener(_fieldChanged);
    _confettiController.addListener(_confettiAnimationChanged);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavingsCalculatorFormBloc, SavingsCalculatorFormState>(
      listener: (context, state) => _showConfetti(state: state),
      builder: (context, state) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _confettiWidget(),
            ),
            Align(
              alignment: Alignment.center,
              child: _body(state: state),
            )
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _confettiController.dispose();
    _formBloc.close();
    super.dispose();
  }
  
  Widget _confettiWidget() {
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
    );
  }
  
  Widget _body({required SavingsCalculatorFormState state}) {
    if (state.formSubmitted) {
      return RichText(
        text: TextSpan(
          text:  "You save  ",
          style: TextStyle(
            fontSize: _titleTextSize(),
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
          children: [
            TextSpan(
              text: Currency.create(cents: state.totalSavings < 0 ? 0 : state.totalSavings),
              style: TextStyle(
                fontSize: _currencyTextSize(),
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(28, 132, 26, 1)
              )
            )
          ]
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _formField(state: state),
        _submitButton(state: state)
      ],
    );
  }
  
  Widget _submitButton({required SavingsCalculatorFormState state}) {
    if (!state.isFieldVisible) {
      return ElevatedButton(
        onPressed: () => _formBloc.add(FieldVisibilityChanged(fieldVisible: !state.isFieldVisible)),
        child: Text(
          "Start",
          style: TextStyle(
            fontSize: _buttonTextSize(),
            fontWeight: FontWeight.bold
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 20,
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h)
        )
      );
    }
    
    return ElevatedButton(
      onPressed: state.isFieldValid && _controller.text.isNotEmpty
        ? () => _submit()
        : null,
      child: Text(
        _buttonText(state: state),
        style: TextStyle(
          fontSize: _buttonTextSize(),
          fontWeight: FontWeight.bold
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 20,
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h)
      )
    );
  }
  
  Widget _formField({required SavingsCalculatorFormState state}) {
    if (!state.isFieldVisible) {
      return Text(
        "Calculate your savings!",
        style: TextStyle(
          fontSize: _titleTextSize(),
          fontWeight: FontWeight.bold,
          color: Colors.black
        )
      );
    }
    
    return SizedBox(
      width: .3.sw,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        onFieldSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          hintText: _hintText(state: state),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: _inputTextSize(),
            color: Colors.black26
          )
        ),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: _inputTextSize()
        ),
        validator: (_) => !state.isFieldValid && _controller.text.isNotEmpty
          ? "Please only use digits!"
          : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [_inputFormatter],
      )
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

  void _confettiAnimationChanged() {
    if (_confettiController.state == ConfettiControllerState.stopped) {
      _formBloc.add(ResetForm());
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

  void _showConfetti({required SavingsCalculatorFormState state}) {
    if (state.formSubmitted && state.totalSavings > 0 && _confettiController.state != ConfettiControllerState.playing) {
      _confettiController.play();
    }
  }

  double _titleTextSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 60.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 50.sp;
    }
    return 40.sp;
  }

  double _currencyTextSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 65.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 55.sp;
    }
    return 45.sp;
  }

  double _inputTextSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 55.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 45.sp;
    }
    return 35.sp;
  }

  double _buttonTextSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 75.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 45.sp;
    }
    return 35.sp;
  }
}