import 'package:dicoding_final/features/detail/domain/entities/category.dart';
import 'package:dicoding_final/features/detail/domain/entities/customer_review.dart';
import 'package:dicoding_final/features/detail/domain/entities/menu.dart';
import 'package:equatable/equatable.dart';

class DetailRestaurant extends Equatable {
  const DetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menu,
    required this.rating,
    required this.customerReviews,
  });

  const DetailRestaurant.empty()
      : this(
          id: '',
          name: '',
          description: '',
          city: '',
          address: '',
          pictureId: '',
          categories: const [Category(name: '')],
          menu: const Menu(
            foods: [Category(name: '')],
            drinks: [Category(name: '')],
          ),
          rating: 1,
          customerReviews: const [
            CustomerReview(name: '', review: '', date: ''),
          ],
        );

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menu menu;
  final double rating;
  final List<CustomerReview> customerReviews;

  @override
  List<String?> get props => [id];
}
