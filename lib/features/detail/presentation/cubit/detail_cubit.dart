import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({required GetDetailRestaurant usecase})
      : _usecase = usecase,
        super(const DetailInitial());
  final GetDetailRestaurant _usecase;

  Future<void> getDetailRestaurant(String restaurantName) async {
    emit(const DetailLoading());
    final result = await _usecase(restaurantName);
    result.fold(
      (failure) => emit(DetailError(message: failure.message)),
      (restaurant) => emit(DetailLoaded(restaurant: restaurant)),
    );
  }
}
