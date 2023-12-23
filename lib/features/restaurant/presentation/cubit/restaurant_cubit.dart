import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit({required GetRestaurants getRestaurants})
      : _getRestaurants = getRestaurants,
        super(const RestaurantInitial());
  final GetRestaurants _getRestaurants;

  Future<void> getRestaurants() async {
    emit(const RestaurantLoading());
    final result = await _getRestaurants();
    result.fold(
      (failure) => emit(RestaurantError(message: failure.errorMessage)),
      (restaurants) => emit(RestaurantLoaded(restaurants: restaurants)),
    );
  }
}
