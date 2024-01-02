import 'package:dicoding_final/core/errors/exception.dart';

abstract class NotificationRemoteDataSource {
  const NotificationRemoteDataSource();

  /// Displays a notification to notify the user.
  ///
  /// This function is responsible for triggering the local display of a
  /// notification without sending any network requests.
  ///
  /// Throws a [CacheException] if there is an issue while processing the
  /// notification.
  Future<void> showNotification();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {



  @override
  Future<void> showNotification() async {
    
  }
}
