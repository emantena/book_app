import 'package:equatable/equatable.dart';

class CreateUserModel extends Equatable {
  final String email;
  final String password;
  final String name;
  final String birthDate;

  const CreateUserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        birthDate,
      ];
}
