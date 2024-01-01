import 'package:dicoding_final/core/errors/error_message.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/delete_saved_restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_saved_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/save_restaurant.dart';
import 'package:flutter/material.dart';

class SavedProvider with ChangeNotifier {
  SavedProvider({
    required SaveRestaurant saveRestaurant,
    required GetSavedRestaurants getSavedRestaurants,
    required DeleteSavedRestaurant deleteSavedRestaurant,
  })  : _saveRestaurant = saveRestaurant,
        _getSavedRestaurant = getSavedRestaurants,
        _deleteSavedRestaurant = deleteSavedRestaurant;
  final SaveRestaurant _saveRestaurant;
  final GetSavedRestaurants _getSavedRestaurant;
  final DeleteSavedRestaurant _deleteSavedRestaurant;

  bool _isLoading = false;
  List<Restaurant> _restaurants = [];
  final Set<String> _favoriteRestaurants = {};
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  List<Restaurant> get restaurants => _restaurants;
  String get messageOfError => _errorMessage;

  bool isFavorite(String restaurantId) {
    return _favoriteRestaurants.contains(restaurantId);
  }

  void toggleFavorite(String restaurantId) {
    _favoriteRestaurants.contains(restaurantId)
        ? _favoriteRestaurants.remove(restaurantId)
        : _favoriteRestaurants.add(restaurantId);

    notifyListeners();
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    _isLoading = true;
    await Future<void>.delayed(const Duration(seconds: 2));
    final result = await _saveRestaurant(restaurant);
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (_) => null,
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getSavedRestaurant() async {
    _isLoading = true;
    await Future.microtask(notifyListeners);
    await Future<void>.delayed(const Duration(seconds: 3));
    final result = await _getSavedRestaurant();
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (restaurants) => _restaurants = restaurants,
    );
    _isLoading = false;
    await Future.microtask(notifyListeners);
  }

  Future<void> deleteSavedRestaurant(Restaurant restaurant) async {
    _isLoading = true;

    final result = await _deleteSavedRestaurant(restaurant);
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (_) => null,
    );
    _isLoading = false;
    notifyListeners();
  }
}
