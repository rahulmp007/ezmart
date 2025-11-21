import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/network/error_mapper.dart';

enum ApiStatus {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  UN_PROCESSABLE_DATA,
  NOT_IMPLEMENTED,
  BAD_GATEWAY,
  SERVICE_UNAVAILABLE,
}

class ErrorHandler implements Exception {
  AppError? appError;

  static AppError handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return ApiStatus.DEFAULT.toAppError(technicalMessage: error.toString());
    }
  }

  static AppError _handleDioError(DioException error) {
    log(error.type.toString());
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiStatus.CONNECT_TIMEOUT.toAppError();
      case DioExceptionType.sendTimeout:
        return ApiStatus.SEND_TIMEOUT.toAppError();
      case DioExceptionType.receiveTimeout:
        return ApiStatus.RECEIVE_TIMEOUT.toAppError();
      case DioExceptionType.cancel:
        return ApiStatus.CANCEL.toAppError();
      case DioExceptionType.unknown:
        return ApiStatus.DEFAULT.toAppError();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 404:
            return ApiStatus.NOT_FOUND.toAppError();

          case 422:
            return ApiStatus.UN_PROCESSABLE_DATA.toAppError();

          case 500:
            return ApiStatus.INTERNAL_SERVER_ERROR.toAppError();
          case 501:
            return ApiStatus.DEFAULT.toAppError();
          case 502:
            return ApiStatus.DEFAULT.toAppError();
          default:
            return ApiStatus.DEFAULT.toAppError();
        }
      default:
        return ApiStatus.DEFAULT.toAppError();
    }
  }
}
