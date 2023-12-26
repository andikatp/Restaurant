import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.city,
    required super.rating,
  });

  const RestaurantModel.empty()
      : this(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 1.1,
        );

  factory RestaurantModel.fromJson(ResultMap map) {
    return RestaurantModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      pictureId: map['pictureId'] as String,
      city: map['city'] as String,
      rating: (map['rating'] as num).toDouble(),
    );
  }

  ResultMap toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }
}
