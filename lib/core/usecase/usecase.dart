import 'package:dicoding_final/core/utils/typedef.dart';

abstract class UseCaseWithoutParams<Type, Params> {
  const UseCaseWithoutParams();
  ResultFuture<Type> call();
}

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}
