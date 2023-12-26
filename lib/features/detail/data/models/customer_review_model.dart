import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/domain/entities/customer_review.dart';

class CustomerReviewModel extends CustomerReview {
  const CustomerReviewModel({
    required super.name,
    required super.review,
    required super.date,
  });

  factory CustomerReviewModel.fromJson(ResultMap json) {
    return CustomerReviewModel(
      name: json['name'] as String,
      review: json['review'] as String,
      date: json['date'] as String,
    );
  }

  ResultMap toJson() => {'name': name, 'review': review, 'date': date};
}
