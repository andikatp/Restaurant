import 'package:dicoding_final/features/restaurant/data/models/dish_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/menu.dart';

class MenuModel extends Menu {
  const MenuModel({
    required super.foods,
    required super.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      foods: (json['foods'] as List<dynamic>)
          .map((foods) => DishModel.fromJson(foods as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((drink) => DishModel.fromJson(drink as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foods': foods.map((food) => (food as DishModel).toJson()).toList(),
      'drinks': drinks.map((drink) => (drink as DishModel).toJson()).toList(),
    };
  }
}
