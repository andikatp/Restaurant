import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/search_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit({
    required GetRestaurants getRestaurants,
    required SearchRestaurant searchRestaurant,
  })  : _getRestaurants = getRestaurants,
        _searchRestaurant = searchRestaurant,
        super(const RestaurantInitial());
  final GetRestaurants _getRestaurants;
  final SearchRestaurant _searchRestaurant;

  Future<void> getRestaurants() async {
    emit(const RestaurantLoading());
    final result = await _getRestaurants();
    result.fold(
      (failure) => emit(RestaurantError(message: failure.errorMessage)),
      (restaurants) => emit(RestaurantLoaded(restaurants: restaurants)),
    );
  }

  Future<void> searchRestaurants() async {
    emit(const RestaurantLoading());
    final result = await _searchRestaurant();
    result.fold(
      (failure) => emit(RestaurantError(message: failure.errorMessage)),
      (restaurants) => emit(RestaurantLoaded(restaurants: restaurants)),
    );
  }
}
