import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/data/models/category_model.dart';
import 'package:dicoding_final/features/detail/domain/entities/menu.dart';

class MenuModel extends Menu {
  const MenuModel({required super.foods, required super.drinks});

  factory MenuModel.fromJson(ResultMap json) {
    return MenuModel(
      foods: (json['foods'] as List<dynamic>)
          .map((food) => CategoryModel.fromJson(food as ResultMap))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((drink) => CategoryModel.fromJson(drink as ResultMap))
          .toList(),
    );
  }

  ResultMap toJson() => {'foods': foods, 'drinks': drinks};
}
