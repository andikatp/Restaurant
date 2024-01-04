import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/notification/domain/repositories/notification_repo.dart';

class TurnNotification implements UseCaseWithParams<void, bool> {
  TurnNotification({required NotificationRepo repo}) : _repo = repo;
  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(bool params) {
    return _repo.turnNotification(value: params);
  }
}
