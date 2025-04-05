import 'package:equatable/equatable.dart';

class IndustryIdentifier extends Equatable {
  final String type;
  final String identifier;
  const IndustryIdentifier({
    this.type = '',
    this.identifier = '',
  });

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) {
    return IndustryIdentifier(
      type: json['type'] ?? '',
      identifier: json['identifier'] ?? '',
    );
  }

  @override
  List<Object?> get props => [type, identifier];
}
