import 'package:flutter/material.dart';
import 'package:website/resources/input_formatters/formatter.dart';

class PercentFormatter extends Formatter {
  static const String suffix = "%";
  String value = '';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');

    double? newValueDouble = double.tryParse(newValue.text.replaceAll(suffix, ""));
    if (newValueDouble == null || newValueDouble > 100) return oldValue;

    if (newValue.text.length < oldValue.text.length && !newValue.text.endsWith(suffix)) {
      int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
      String newString = "${newValue.text.substring(0, newValue.text.length - 1)}$suffix";
      value = newString == suffix ? "" : newString;
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }
    
    String oldValueText = oldValue.text.replaceAll(suffix, '');
    String newValueText = newValue.text.replaceAll(suffix, '');

    if (oldValueText != newValueText) {
      int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
      String newString = "$newValueText$suffix";
      value = newString;
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }
    return newValue;
  }

  @override
  String unMasked() {
    return value.replaceAll(RegExp(suffix), '');
  }
}