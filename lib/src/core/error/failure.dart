import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  final String message;
  final int? code;
  final String? technicalMessage;

  const AppError({required this.message, this.code, this.technicalMessage});

  @override
  List<Object?> get props => [message, code, technicalMessage];

  @override
  bool? get stringify => true;
}

class NetworkError extends AppError {
  const NetworkError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

class ServerError extends AppError {
  const ServerError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

class ValidationError extends AppError {
  const ValidationError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

class CacheError extends AppError {
  const CacheError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

class UnknownError extends AppError {
  const UnknownError({
    super.message = 'Something went wrong',
    super.code,
    super.technicalMessage,
  });
}
