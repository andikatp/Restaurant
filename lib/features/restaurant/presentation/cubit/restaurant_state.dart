part of 'restaurant_cubit.dart';

sealed class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

final class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

final class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

final class RestaurantLoaded extends RestaurantState {
  const RestaurantLoaded({required this.restaurants});
  final List<Restaurant> restaurants;
}

final class RestaurantError extends RestaurantState {
  const RestaurantError({required this.message});
  final String message;
}
