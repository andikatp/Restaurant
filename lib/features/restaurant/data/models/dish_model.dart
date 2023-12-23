import 'package:dicoding_final/features/restaurant/domain/entities/dish.dart';

class DishModel extends Dish {
  const DishModel({required super.name});

  factory DishModel.fromJson(Map<String, dynamic> json) =>
      DishModel(name: json['name'] as String);

  Map<String, dynamic> toJson() => {'name': name};
}
