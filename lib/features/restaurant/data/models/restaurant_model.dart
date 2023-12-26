import 'package:dicoding_final/features/restaurant/data/models/dish_model.dart';
import 'package:dicoding_final/features/restaurant/data/models/menu_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.city,
    required super.rating,
    required super.menu,
  });
  const RestaurantModel.empty()
      : this(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 1.1,
          menu: const MenuModel(
            foods: [DishModel(name: '')],
            drinks: [DishModel(name: '')],
          ),
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        pictureId: json['pictureId'] as String,
        city: json['city'] as String,
        rating: (json['rating'] as num).toDouble(),
        menu: MenuModel.fromJson(json['menus'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
        'menus': (menu as MenuModel).toJson(),
      };
}
