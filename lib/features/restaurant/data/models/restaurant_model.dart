import 'package:dart_mappable/dart_mappable.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';

part 'restaurant_model.mapper.dart';

@MappableClass()
class RestaurantModel extends Restaurant with RestaurantModelMappable {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.city,
    required super.rating,
    required super.menus,
  });

  RestaurantModel.empty() : super.empty();
}
