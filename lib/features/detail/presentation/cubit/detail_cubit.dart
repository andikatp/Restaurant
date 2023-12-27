import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_state.dart';

const serverFailureMessage = 'Ups, API Error. please try again!';
const generalFailureMessage = 'Ups, check your connection';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({required GetDetailRestaurant usecase})
      : _usecase = usecase,
        super(const DetailInitial());
  final GetDetailRestaurant _usecase;

  Future<void> getDetailRestaurant(String restaurantId) async {
    emit(const DetailLoading());
    final result = await _usecase(restaurantId);
    result.fold(
      (failure) => emit(DetailError(message: errorMessage(failure))),
      (restaurant) => emit(DetailLoaded(restaurant: restaurant)),
    );
  }
}

String errorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    default:
      return generalFailureMessage;
  }
}
