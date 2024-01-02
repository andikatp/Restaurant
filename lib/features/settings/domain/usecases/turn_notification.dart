import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/settings/domain/repositories/notification_repo.dart';

class TurnNotification implements UseCaseWithoutParams<void, void> {
  TurnNotification({required NotificationRepo repo}) : _repo = repo;
  final NotificationRepo _repo;

  @override
  ResultFuture<void> call() {
    return _repo.turnNotification();
  }
}
