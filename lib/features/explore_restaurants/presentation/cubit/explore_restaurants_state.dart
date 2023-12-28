part of 'explore_restaurants_cubit.dart';

sealed class ExploreRestaurantsState extends Equatable {
  const ExploreRestaurantsState();

  @override
  List<Object> get props => [];
}

final class GetRestaurantsInitial extends ExploreRestaurantsState {
  const GetRestaurantsInitial();
}

final class SearchInitial extends ExploreRestaurantsState {
  const SearchInitial();
}

final class GetRestaurantsLoading extends ExploreRestaurantsState {
  const GetRestaurantsLoading();
}

final class SearchLoading extends ExploreRestaurantsState {
  const SearchLoading();
}

final class GetRestaurantsLoaded extends ExploreRestaurantsState {
  const GetRestaurantsLoaded({required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  List<Object> get props =>
      restaurants.map((restaurant) => restaurant.id).toList();
}

final class SearchLoaded extends ExploreRestaurantsState {
  const SearchLoaded({required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

final class GetRestaurantsError extends ExploreRestaurantsState {
  const GetRestaurantsError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

final class SearchError extends ExploreRestaurantsState {
  const SearchError({required this.message});
  final String message;

  @override
  List<String> get props => [message];
}
