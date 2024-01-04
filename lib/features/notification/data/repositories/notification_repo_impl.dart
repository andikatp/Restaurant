import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/notification/data/datasources/notification_data_source.dart';
import 'package:dicoding_final/features/notification/domain/repositories/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  NotificationRepoImpl({required NotificationDataSource dataSource})
      : _dataSource = dataSource;
  final NotificationDataSource _dataSource;

  @override
  ResultFuture<void> turnNotification({required bool value}) async {
    try {
      await _dataSource.showNotification(isScheduled: value);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
