import 'package:shared_preferences/shared_preferences.dart';

abstract class Preferences {
  const Preferences();
  bool get isDailyRestaurantctive;
  void setDailyNews({bool value = false});
}

class PreferencesImpl implements Preferences {
  PreferencesImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const dailyNews = 'DAILY_NEWS';

  @override
  bool get isDailyRestaurantctive  =>
      _sharedPreferences.getBool(dailyNews) ?? false;

  @override
  void setDailyNews({bool value = false}) {
    _sharedPreferences.setBool(dailyNews, value);
  }
}
