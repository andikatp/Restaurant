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
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  List<Restaurant> get restaurants => _restaurants;
  String get messageOfError => _errorMessage;

  Future<void> saveRestaurant(Restaurant restaurant) async {
    _isLoading = true;
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

    final result = await _getSavedRestaurant();
    result.fold(
      (failure) => _errorMessage = errorMessage(failure),
      (restaurants) => _restaurants = restaurants,
    );
    _isLoading = false;
    notifyListeners();
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
