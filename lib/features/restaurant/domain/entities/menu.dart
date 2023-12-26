import 'package:dicoding_final/features/restaurant/domain/entities/dish.dart';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  const Menu({
    required this.foods,
    required this.drinks,
  });
  final List<Dish> foods;
  final List<Dish> drinks;

  @override
  List<Object?> get props => [foods, drinks];
}
