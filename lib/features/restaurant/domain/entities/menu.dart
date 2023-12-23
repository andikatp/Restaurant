import 'package:dicoding_final/features/restaurant/domain/entities/dish.dart';
import 'package:equatable/equatable.dart';

class Menus extends Equatable {
  const Menus({
    required this.foods,
    required this.drinks,
  });
  final List<Dish> foods;
  final List<Dish> drinks;

  @override
  List<Object?> get props => [foods, drinks];
}
