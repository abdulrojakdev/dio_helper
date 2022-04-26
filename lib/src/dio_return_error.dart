//RETURN ERROR
import 'package:dio/dio.dart';

import 'dio_error_entity.dart';
import 'dio_error_language_entity.dart';
import 'dio_error_message.dart';


dioReturnError(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      {
        return DioErrorEntity(
            statusCode: -1,
            errorLanguageEntity: _dioErrorMessage('REQUEST_CANCEL'));
      }
    case DioErrorType.connectTimeout:
      {
        return DioErrorEntity(
            statusCode: -1,
            errorLanguageEntity: _dioErrorMessage('CONNECTION_TIME_OUT'));
      }
    case DioErrorType.sendTimeout:
      {
        return DioErrorEntity(
            statusCode: -1,
            errorLanguageEntity: _dioErrorMessage('REQUEST_TIME_OUT'));
      }
    case DioErrorType.receiveTimeout:
      {
        return DioErrorEntity(
            statusCode: -1,
            errorLanguageEntity: _dioErrorMessage('RESPONSE_TIME_OUT'));
      }
    case DioErrorType.other:
      return DioErrorEntity(
          statusCode: 0,
          errorLanguageEntity: _dioErrorMessage('CHECK_INTERNET_CONNECTION'));

    case DioErrorType.response:
      try {
        int? errorCode = error.response?.statusCode;
        switch (errorCode) {
          case 400:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('REQUEST_SYNTAX'));

          case 403:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('SERVER_REFUSED'));

          case 404:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('DATA_NOT_AVAILABLE'));

          case 405:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('REQUEST_FORBIDDEN'));

          case 500:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('SERVER_INTERNAL'));

          case 502:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('INVALID_REQUEST'));

          case 503:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('SERVER_DOWN'));

          case 505:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('NOT_SUPPORT_HTTP'));

          default:
            return DioErrorEntity(
                statusCode: errorCode!,
                errorLanguageEntity: _dioErrorMessage('UNKNOWN_MISTAKE'));
        }
      } on Exception catch (_) {
        return DioErrorEntity(
            statusCode: -1,
            errorLanguageEntity: _dioErrorMessage('UNKNOWN_ERROR'));
      }

    default:
      return DioErrorEntity(
          statusCode: -1, errorLanguageEntity: _dioErrorMessage(error.message));
  }
}

_dioErrorMessage(String error) {
  switch (error) {
    case 'REQUEST_CANCEL':
      return DioErrorLanguageEntity(
          defaultLanguage: requestCancelError, otherLanguage: 'requestCancel');

    case 'CONNECTION_TIME_OUT':
      return DioErrorLanguageEntity(
          defaultLanguage: connectionTimeOutError,
          otherLanguage: 'connectionTimeOut');

    case 'REQUEST_TIME_OUT':
      return DioErrorLanguageEntity(
          defaultLanguage: requestTimeOutError,
          otherLanguage: 'requestTimeOut');

    case 'RESPONSE_TIME_OUT':
      return DioErrorLanguageEntity(
          defaultLanguage: responseTimeOutError,
          otherLanguage: 'responseTimeOut');

    case 'CHECK_INTERNET_CONNECTION':
      return DioErrorLanguageEntity(
          defaultLanguage: checkInternetConnectionError,
          otherLanguage: 'checkInternetConnection');

    case 'REQUEST_SYNTAX':
      return DioErrorLanguageEntity(
          defaultLanguage: requestSyntaxError, otherLanguage: 'requestSyntax');

    case 'SERVER_REFUSED':
      return DioErrorLanguageEntity(
          defaultLanguage: serverRefusedError, otherLanguage: 'serverRefused');

    case 'DATA_NOT_AVAILABLE':
      return DioErrorLanguageEntity(
          defaultLanguage: dataNotAvailableError,
          otherLanguage: 'dataNotAvailable');

    case 'REQUEST_FORBIDDEN':
      return DioErrorLanguageEntity(
          defaultLanguage: requestForbiddenError,
          otherLanguage: 'requestForbidden');

    case 'SERVER_INTERNAL':
      return DioErrorLanguageEntity(
          defaultLanguage: serverInternalError,
          otherLanguage: 'serverInternal');

    case 'INVALID_REQUEST':
      return DioErrorLanguageEntity(
          defaultLanguage: invalidRequestError,
          otherLanguage: 'invalidRequest');

    case 'SERVER_DOWN':
      return DioErrorLanguageEntity(
          defaultLanguage: serverDownError, otherLanguage: 'serverDown');

    case 'NOT_SUPPORT_HTTP':
      return DioErrorLanguageEntity(
          defaultLanguage: notSupportHTTPError,
          otherLanguage: 'notSupportHTTP');

    case 'UNKNOWN_MISTAKE':
      return DioErrorLanguageEntity(
          defaultLanguage: unknownMistakeError,
          otherLanguage: 'unknownMistake');

    case 'UNKNOWN_ERROR':
      return DioErrorLanguageEntity(
          defaultLanguage: unknownError, otherLanguage: 'unknownError');

    default:
      return DioErrorLanguageEntity(
          defaultLanguage: error, otherLanguage: error);
  }
}
