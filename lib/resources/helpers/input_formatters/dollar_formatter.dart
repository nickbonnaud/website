import 'package:flutter/material.dart';
import 'package:website/resources/helpers/input_formatters/formatter.dart';

class DollarFormatter extends Formatter {
  static const String prefix = "\$";
  static const String separator = ',';
  String value = '';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty || newValue.text.replaceAll("\$", "").replaceAll(",", "").isEmpty) return newValue.copyWith(text: '');
    
    int? newValueInteger = int.tryParse(newValue.text.replaceAll("\$", "").replaceAll(",", ""));
    if (newValueInteger == null) return oldValue;
    
    String oldValueText = oldValue.text.replaceAll("\$", "").replaceAll(",", "");
    String newValueText = newValue.text.replaceAll("\$", "").replaceAll(",", "");

    if (oldValue.text.endsWith(separator) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }
    
    if (oldValueText != newValueText) {
      int selectionIndex = (newValue.text.length) - newValue.selection.extentOffset;
      final chars = newValueText.split('');
      
      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }
      
      value = "\$${newString.toString()}";
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(
          offset: value.length - selectionIndex,
        ),
      );
    }
    return newValue;
  }

  @override
  String unMasked() {
    return value.replaceAll("\$", "").replaceAll(",", "");
  }
}