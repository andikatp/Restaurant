import 'package:dicoding_final/core/errors/error_message.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/review_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({
    required GetDetailRestaurant usecase,
    required ReviewRestaurant addReview,
  })  : _getDetailUsecase = usecase,
        _addReview = addReview,
        super(const DetailInitial());
  final GetDetailRestaurant _getDetailUsecase;
  final ReviewRestaurant _addReview;

  Future<void> getDetailRestaurant(String restaurantId) async {
    emit(const DetailLoading());
    final result = await _getDetailUsecase(restaurantId);
    result.fold(
      (failure) => emit(DetailError(message: errorMessage(failure))),
      (restaurant) => emit(DetailLoaded(restaurant: restaurant)),
    );
  }

  Future<void> addReview(String restaurantId, String review) async {
    emit(const DetailLoading());
    final result =
        await _addReview(ReviewParams(id: restaurantId, review: review));
    result.fold(
      (failure) => emit(DetailError(message: errorMessage(failure))),
      (_) => emit(const ReviewAdded()),
    );
  }
}
