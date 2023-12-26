import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({required super.name});

  factory CategoryModel.fromJson(ResultMap json) {
    return CategoryModel(name: json['name'] as String);
  }

  ResultMap toJson() => {'name': name};
}
