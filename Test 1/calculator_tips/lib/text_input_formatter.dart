import 'package:flutter/services.dart';

class RegExInputFormatter implements TextInputFormatter {
  final RegExp regExp;

  RegExInputFormatter._(this.regExp);

  factory RegExInputFormatter.withRegex(String regexString) {
    try {
      final regex = RegExp(regexString);
      return RegExInputFormatter._(regex);
    } catch (e) {
      assert(false, e.toString());
      throw AssertionError('Cadena inválida: $e');
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = isValid(oldValue.text);
    final newValueValid = isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool isValid(String value) {
    try {
      final matches = regExp.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      assert(false, e.toString());
      return true;
    }
  }
}
