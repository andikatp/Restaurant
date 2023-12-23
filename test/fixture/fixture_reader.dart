import 'dart:io';

String fixtureReader(String fileName) =>
    File('test/fixture/$fileName').readAsStringSync();
