import 'package:dicoding_final/core/utils/typedef.dart';

abstract class UseCase<Type> {
  const UseCase();
  ResultFuture<Type> call();
}
