import 'package:dicoding_final/core/utils/typedef.dart';

abstract class NotificationRepo {
  const NotificationRepo();

  ResultFuture<void> turnNotification();
}
