import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? email;
  final String id;
  final String? name;
  final DateTime? birthDate;
  final String? photo;

  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.birthDate,
  });

  static const empty = UserModel(id: '');

  UserModel copyWith({
    String? email,
    String? id,
    String? name,
    DateTime? birthDate,
    String? photo,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photo,
        birthDate,
      ];

  static UserModel fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json['email'],
      name: json['name'],
      photo: json['photo'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['birthDate'] = birthDate;
    data['photo'] = photo;
    return data;
  }
}
