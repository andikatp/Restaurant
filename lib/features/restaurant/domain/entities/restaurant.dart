import 'package:equatable/equatable.dart';

class Restaurant extends Equatable  {
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.empty()
      : this(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 1,
          menus: Menus(foods: [], drinks: []),
        );

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  @override
  List<String?> get props => [id];
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });
  final List<Dish> foods;
  final List<Dish> drinks;
}

class Dish {
  Dish({
    required this.name,
  });
  final String name;
}
