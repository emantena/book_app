import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class UserName extends FormzInput<String, NameValidationError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String? value) {
    var isValid = value != null && value != '' && value.length >= 2;

    return isValid ? null : NameValidationError.invalid;
  }
}
