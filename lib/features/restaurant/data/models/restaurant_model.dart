import 'package:dart_mappable/dart_mappable.dart';
import 'package:dicoding_final/features/restaurant/data/models/dish_model.dart';
import 'package:dicoding_final/features/restaurant/data/models/menu_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';

part 'restaurant_model.mapper.dart';

@MappableClass()
class RestaurantModel extends Restaurant with RestaurantModelMappable {
  RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.city,
    required super.rating,
    required MenuModel menus,
  }) : super(menus: menus);
  RestaurantModel.empty()
      : this(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 1.1,
          menus: const MenuModel(
            foods: [DishModel(name: '')],
            drinks: [DishModel(name: '')],
          ),
        );
}
