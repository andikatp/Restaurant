import 'package:dicoding_final/features/detail/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  const Menu({
    required this.foods,
    required this.drinks,
  });

  final List<Category> foods;
  final List<Category> drinks;

  @override
  List<Object?> get props => [foods, drinks];
}
