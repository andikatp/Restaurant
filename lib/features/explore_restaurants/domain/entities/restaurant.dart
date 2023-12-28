import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  const Restaurant.empty()
      : this(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 1.1,
        );

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  @override
  List<String?> get props => [id];
}