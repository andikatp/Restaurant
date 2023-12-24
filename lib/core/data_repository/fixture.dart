import 'package:flutter/services.dart' show rootBundle;

Future<String> fixture() =>
    rootBundle.loadString('assets/data_repository/restaurants.json');
