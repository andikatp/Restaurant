import 'dart:async';

import 'package:dicoding_final/features/explore_restaurants/data/datasources/local/DAO/restaurant_dao.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [RestaurantModel])
abstract class AppDatabase extends FloorDatabase {
  RestaurantDao get restaurantDAO;
}
