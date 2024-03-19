import 'error_handler.dart';

enum DataSource {
  clientClosedRequest,
  internalServerError,
  networkConnectError,
  connectionTimeout,
  fireBaseError,
  unexpected,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.clientClosedRequest:
        return const Failure(
            code: StatusCode.clientClosedRequest,
            message: StatusMessage.clientClosedRequest);
      case DataSource.connectionTimeout:
        return const Failure(
            code: StatusCode.connectionTimeout,
            message: StatusMessage.connectionTimeout);
      case DataSource.internalServerError:
        return const Failure(
            code: StatusCode.internalServerError,
            message: StatusMessage.internalServerError);
      case DataSource.networkConnectError:
        return const Failure(
            code: StatusCode.networkConnectError,
            message: StatusMessage.networkConnectError);
      case DataSource.fireBaseError:
        return const Failure(
            code: StatusCode.internalServerError,
            message: StatusMessage.fireBaseServerError);
      case DataSource.unexpected:
        return const Failure(
            code: StatusCode.unexpected, message: StatusMessage.unexpected);
    }
  }
}

class StatusCode {
  static const int clientClosedRequest = 499;
  static const int internalServerError = 500;
  static const int networkConnectError = 599;
  static const int connectionTimeout = 408;

  static const int unexpected = -1;
}

class StatusMessage {
  static const String clientClosedRequest =
      "Something went wrong while fetching details. Try again later.";
  static const String internalServerError =
      "Something went wrong. Try again later.";
  static const String networkConnectError =
      "Internet connection timeout. Try again later.";
  static const String unexpected = "Unexpected Error.";
  static const String fireBaseServerError = "There is an Error on Server.";
  static const String connectionTimeout =
      "Connection timed out. Please check your internet connection and try again.";
}
