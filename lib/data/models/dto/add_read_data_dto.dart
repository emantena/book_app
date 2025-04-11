import 'package:equatable/equatable.dart';

class AddReadDataDto extends Equatable {
  final String bookId;
  final DateTime readDate;

  const AddReadDataDto({
    required this.bookId,
    required this.readDate,
  });

  @override
  List<Object?> get props => [bookId, readDate];
}
