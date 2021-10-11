class NetworkException implements Exception {
  NetworkException({
    this.message,
    this.errorCode,
    this.response,
  });

  final String message;
  final String errorCode;
  final String response;

  @override
  String toString() =>
      "В запросе $response возникла ошибка: $errorCode $message";
}
