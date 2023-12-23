import 'package:dart_mappable/dart_mappable.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/dish.dart';

part 'dish_model.mapper.dart';

@MappableClass()
class DishModel extends Dish with DishModelMappable {
  const DishModel({required super.name});
}
