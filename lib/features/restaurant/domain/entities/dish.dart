import 'package:equatable/equatable.dart';

class Dish extends Equatable {
  const Dish({
    required this.name,
  });
  final String name;

  @override
  List<String?> get props => [name];
}
