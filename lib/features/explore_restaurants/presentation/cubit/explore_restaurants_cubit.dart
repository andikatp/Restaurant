import 'package:dicoding_final/core/errors/error_message.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/search_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'explore_restaurants_state.dart';

class ExploreRestaurantsCubit extends Cubit<ExploreRestaurantsState> {
  ExploreRestaurantsCubit({
    required GetRestaurants getRestaurantUsecase,
    required SearchRestaurant searchRestaurantUsecase,
  })  : _getRestaurantUsecase = getRestaurantUsecase,
        _searchRestaurantUsecase = searchRestaurantUsecase,
        super(const GetRestaurantsInitial());
  final GetRestaurants _getRestaurantUsecase;
  final SearchRestaurant _searchRestaurantUsecase;

  Future<void> getRestaurants() async {
    emit(const GetRestaurantsLoading());
    final result = await _getRestaurantUsecase();
    result.fold(
      (failure) => emit(GetRestaurantsError(message: errorMessage(failure))),
      (restaurants) => emit(GetRestaurantsLoaded(restaurants: restaurants)),
    );
  }

  Future<void> searchRestaurant(String restaurantName) async {
    emit(const SearchLoading());
    final result = await _searchRestaurantUsecase(restaurantName);
    result.fold(
      (failure) => emit(SearchError(message: errorMessage(failure))),
      (restaurants) => emit(SearchLoaded(restaurants: restaurants)),
    );
  }
}
