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

  List<Restaurant> _restaurants = [];
  String _errorMessage = '';

  List<Restaurant> get restaurants => _restaurants;
  String get messageOfError => _errorMessage;

  bool isFavorite(Restaurant restaurant) {
    getSavedRestaurant();
    return _restaurants.contains(restaurant);
  }

  void toggleFavorite(Restaurant restaurant) {
    _restaurants.contains(restaurant)
        ? deleteSavedRestaurant(restaurant)
        : saveRestaurant(restaurant);
    notifyListeners();
  }

  Future<void> getSavedRestaurant() async {
    final result = await _getSavedRestaurant();
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (restaurants) => _restaurants = restaurants,
    );
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    final result = await _saveRestaurant(restaurant);
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (_) => _restaurants.add(restaurant),
    );
    notifyListeners();
  }

  Future<void> deleteSavedRestaurant(Restaurant restaurant) async {
    final result = await _deleteSavedRestaurant(restaurant);
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (_) => _restaurants.remove(restaurant),
    );
    notifyListeners();
  }
}
