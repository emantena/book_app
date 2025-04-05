import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

enum BirthDateValidationError { invalid }

class BirthDate extends FormzInput<String, BirthDateValidationError> {
  const BirthDate.pure() : super.pure('');
  const BirthDate.dirty([super.value = '']) : super.dirty();

  static final _birthDateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');

  @override
  BirthDateValidationError? validator(String value) {
    // if (value.length != 10) return null;

    final isDate = _birthDateRegExp.hasMatch(value);

    if (!isDate) return BirthDateValidationError.invalid;

    var date = DateFormat('dd/MM/yyyy').parse(value);
    final age = DateTime.now().year - date.year;

    return age >= 6 ? null : BirthDateValidationError.invalid;
  }
}
