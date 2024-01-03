import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/settings/domain/repositories/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  NotificationRepoImpl({required NotificationRepo repo}) : _repo = repo;
  final NotificationRepo _repo;

  @override
  ResultFuture<void> turnNotification() {
    return _repo.turnNotification();
  }
}
