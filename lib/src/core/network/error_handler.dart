import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/network/error_mapper.dart';

enum ApiStatus {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
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

// lib/core/network/firebase_error_codes.dart

/// Firebase Authentication error codes
enum FirebaseAuthErrorCode {
  // Popup and UI interaction errors
  popupClosedByUser('auth/popup-closed-by-user'),
  popupBlocked('auth/popup-blocked'),
  cancelledPopupRequest('auth/cancelled-popup-request'),

  // Account linking and credential errors
  accountExistsWithDifferentCredential(
    'auth/account-exists-with-different-credential',
  ),
  credentialAlreadyInUse('auth/credential-already-in-use'),
  providerAlreadyLinked('auth/provider-already-linked'),

  // Network related errors
  networkRequestFailed('auth/network-request-failed'),

  // Configuration errors
  operationNotAllowed('auth/operation-not-allowed'),
  unauthorizedDomain('auth/unauthorized-domain'),
  invalidApiKey('auth/invalid-api-key'),
  appNotAuthorized('auth/app-not-authorized'),
  invalidAppCredential('auth/invalid-app-credential'),
  appNotVerified('auth/app-not-verified'),

  // User account status errors
  userDisabled('auth/user-disabled'),
  userNotFound('auth/user-not-found'),
  userTokenExpired('auth/user-token-expired'),
  userMismatch('auth/user-mismatch'),
  userSignedOut('auth/user-signed-out'),

  // Credential validation errors
  wrongPassword('auth/wrong-password'),
  invalidCredential('auth/invalid-credential'),
  invalidEmail('auth/invalid-email'),
  invalidVerificationCode('auth/invalid-verification-code'),
  invalidVerificationId('auth/invalid-verification-id'),
  invalidPhoneNumber('auth/invalid-phone-number'),
  invalidAppId('auth/invalid-app-id'),
  invalidMessagePayload('auth/invalid-message-payload'),
  invalidSender('auth/invalid-sender'),
  invalidRecipientEmail('auth/invalid-recipient-email'),

  // Registration and email errors
  emailAlreadyInUse('auth/email-already-in-use'),
  weakPassword('auth/weak-password'),
  missingEmail('auth/missing-email'),
  missingPassword('auth/missing-password'),
  missingPhoneNumber('auth/missing-phone-number'),
  missingVerificationCode('auth/missing-verification-code'),
  missingVerificationId('auth/missing-verification-id'),

  // Session and token errors
  sessionExpired('auth/session-expired'),
  invalidUserToken('auth/invalid-user-token'),
  revokedIdToken('auth/revoked-id-token'),
  invalidIdToken('auth/invalid-id-token'),
  expiredIdToken('auth/expired-id-token'),

  // Security and rate limiting
  tooManyRequests('auth/too-many-requests'),
  requiresRecentLogin('auth/requires-recent-login'),
  quotaExceeded('auth/quota-exceeded'),
  captchaCheckFailed('auth/captcha-check-failed'),

  // Email verification
  unverifiedEmail('auth/unverified-email'),
  invalidActionCode('auth/invalid-action-code'),
  expiredActionCode('auth/expired-action-code'),

  // Multi-factor authentication
  multiFactorAuthRequired('auth/multi-factor-auth-required'),
  missingMultiFactorSession('auth/missing-multi-factor-session'),
  missingMultiFactorInfo('auth/missing-multi-factor-info'),
  invalidMultiFactorSession('auth/invalid-multi-factor-session'),
  multiFactorInfoNotFound('auth/multi-factor-info-not-found'),

  // Unknown error
  unknown('auth/unknown');

  final String value;
  const FirebaseAuthErrorCode(this.value);

  /// Get enum from string value
  static FirebaseAuthErrorCode fromValue(String value) =>
      FirebaseAuthErrorCode.values.firstWhere(
        (e) => e.value == value,
        orElse: () => FirebaseAuthErrorCode.unknown,
      );

  /// Check if the error code is for popup/UI interaction
  bool get isPopupError =>
      this == popupClosedByUser ||
      this == popupBlocked ||
      this == cancelledPopupRequest;

  /// Check if the error code is for account linking
  bool get isAccountLinkingError =>
      this == accountExistsWithDifferentCredential ||
      this == credentialAlreadyInUse ||
      this == providerAlreadyLinked;

  /// Check if the error code is for network issues
  bool get isNetworkError => this == networkRequestFailed;

  /// Check if the error code is for configuration issues
  bool get isConfigurationError =>
      this == operationNotAllowed ||
      this == unauthorizedDomain ||
      this == invalidApiKey ||
      this == appNotAuthorized;

  /// Check if the error code is for user account issues
  bool get isUserAccountError =>
      this == userDisabled || this == userNotFound || this == userTokenExpired;

  /// Check if the error code is for credential validation
  bool get isCredentialError =>
      this == wrongPassword ||
      this == invalidCredential ||
      this == invalidEmail ||
      this == invalidPhoneNumber;

  /// Check if the error code requires user action
  bool get requiresUserAction =>
      isPopupError ||
      isAccountLinkingError ||
      isUserAccountError ||
      isCredentialError ||
      this == emailAlreadyInUse ||
      this == weakPassword ||
      this == requiresRecentLogin;

  /// Check if the error allows retry
  bool get shouldRetry =>
      isPopupError ||
      isNetworkError ||
      isCredentialError ||
      this == userNotFound ||
      this == tooManyRequests;
}

/// General Firebase error codes (Firestore, Storage, etc.)
enum FirebaseErrorCode {
  // Permission errors
  permissionDenied('permission-denied'),

  // Network errors
  unavailable('unavailable'),
  deadlineExceeded('deadline-exceeded'),
  resourceExhausted('resource-exhausted'),

  // Data errors
  notFound('not-found'),
  alreadyExists('already-exists'),
  outOfRange('out-of-range'),
  dataLoss('data-loss'),

  // Configuration errors
  failedPrecondition('failed-precondition'),
  aborted('aborted'),
  internal('internal'),

  // Unknown error
  unknown('unknown');

  final String value;
  const FirebaseErrorCode(this.value);

  static FirebaseErrorCode fromValue(String value) =>
      FirebaseErrorCode.values.firstWhere(
        (e) => e.value == value,
        orElse: () => FirebaseErrorCode.unknown,
      );
}

class ErrorHandler implements Exception {
  AppError? appError;

  static AppError handle(dynamic error) {
    log('Error => ${error.runtimeType}');

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

          case 401:
            return ApiStatus.UNAUTHORISED.toAppError();

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
