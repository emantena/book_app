import 'package:equatable/equatable.dart';

class ReadMetaModel extends Equatable {
  final int? targetYear; // O ano em que o usuário planeja ler o livro (null = "Não sei")
  final DateTime createdAt;

  ReadMetaModel({
    this.targetYear,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ReadMetaModel.fromJson(Map<String, dynamic> json) {
    return ReadMetaModel(
      targetYear: json['targetYear'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetYear': targetYear,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [targetYear, createdAt];
}
