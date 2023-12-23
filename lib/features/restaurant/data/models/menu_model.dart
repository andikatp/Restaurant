import 'package:dart_mappable/dart_mappable.dart';
import 'package:dicoding_final/features/restaurant/data/models/dish_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/menu.dart';

part 'menu_model.mapper.dart';

@MappableClass()
class MenuModel extends Menus with MenuModelMappable {
  const MenuModel({
    required List<DishModel> foods,
    required List<DishModel> drinks,
  }) : super(foods: foods, drinks: drinks);
}
