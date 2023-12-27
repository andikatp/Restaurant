import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';
import 'package:equatable/equatable.dart';

class ReviewRestaurant implements UseCaseWithParams<void, ReviewParams> {
  ReviewRestaurant({required DetailRepo repo}) : _repo = repo;
  final DetailRepo _repo;

  @override
  ResultFuture<void> call(ReviewParams review) {
    return _repo.reviewRestaurant(review.id, review.review);
  }
}

class ReviewParams extends Equatable {
  const ReviewParams({required this.id, required this.review});
  final String id;
  final String review;

  @override
  List<String?> get props => [id];
}
