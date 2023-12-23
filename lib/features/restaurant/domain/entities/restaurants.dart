import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:equatable/equatable.dart';

class Restaurants extends Equatable {
  const Restaurants({required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  List<Object?> get props => [restaurants];
}
