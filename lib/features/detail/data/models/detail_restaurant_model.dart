import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/data/models/category_model.dart';
import 'package:dicoding_final/features/detail/data/models/customer_review_model.dart';
import 'package:dicoding_final/features/detail/data/models/menu_model.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';

class DetailRestaurantModel extends DetailRestaurant {
  const DetailRestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.address,
    required super.pictureId,
    required super.categories,
    required super.menu,
    required super.rating,
    required super.customerReviews,
  });
  
  const DetailRestaurantModel.empty() : super.empty();

  factory DetailRestaurantModel.fromJson(ResultMap json) {
    return DetailRestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      pictureId: json['pictureId'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((category) => CategoryModel.fromJson(category as ResultMap))
          .toList(),
      menu: MenuModel.fromJson(json['menus'] as ResultMap),
      rating: (json['rating'] as num).toDouble(),
      customerReviews: (json['customerReviews'] as List<dynamic>)
          .map((review) => CustomerReviewModel.fromJson(review as ResultMap))
          .toList(),
    );
  }

  ResultMap toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'categories': categories
          .map((category) => (category as CategoryModel).toJson())
          .toList(),
      'menus': (menu as MenuModel).toJson(),
      'rating': rating,
      'customerReviews': customerReviews
          .map((review) => (review as CustomerReviewModel).toJson())
          .toList(),
    };
  }
}
