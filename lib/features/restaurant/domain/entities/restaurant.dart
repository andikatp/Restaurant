import 'package:dicoding_final/features/restaurant/domain/entities/dish.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/menu.dart';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  const Restaurant.empty()
      : this(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 1.1,
          menus: const Menus(
            foods: [Dish(name: '')],
            drinks: [Dish(name: '')],
          ),
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
