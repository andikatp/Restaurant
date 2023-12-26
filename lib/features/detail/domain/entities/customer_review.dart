import 'package:equatable/equatable.dart';

class CustomerReview extends Equatable {
  const CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  @override
  List<Object?> get props => [name, review, date];
}
