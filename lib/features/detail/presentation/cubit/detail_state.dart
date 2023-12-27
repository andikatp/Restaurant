part of 'detail_cubit.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {
  const DetailInitial();
}

final class DetailLoading extends DetailState {
  const DetailLoading();
}

final class ReviewLoading extends DetailState {
  const ReviewLoading();
}

final class DetailLoaded extends DetailState {
  const DetailLoaded({required this.restaurant});
  final DetailRestaurant restaurant;

  @override
  List<Object> get props => [restaurant];
}

final class ReviewAdded extends DetailState {
  const ReviewAdded();
}

final class DetailError extends DetailState {
  const DetailError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
