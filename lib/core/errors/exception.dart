import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
