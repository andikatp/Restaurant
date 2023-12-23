import 'dart:io';

String fixture() =>
    File('lib/core/data_repository/restaurants.json').readAsStringSync();
