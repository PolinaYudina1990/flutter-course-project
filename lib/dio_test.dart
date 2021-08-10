import 'package:dio/dio.dart';
import 'package:places/data/repository/network_exception.dart';

final dio = Dio(baseOptions);
BaseOptions baseOptions = BaseOptions(
    baseUrl: 'https://test-backend-flutter.surfstudio.ru/',
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
    responseType: ResponseType.json);
Future<dynamic> getDioPosts() async {
  initInterceptors();
  final postResponse = await dio.get('/users');
  if (postResponse.statusCode == 200) {
    return postResponse.data;
  }
  throw Exception('HTTP request error. Error code ${postResponse.statusCode}');
}

void initInterceptors() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        print(
          NetworkException(
              response: error.requestOptions.method,
              message: error.error,
              errorCode: error.response.statusCode.toString()),
        );
      },
      onRequest: (options, handler) {
        print('Request sent: ${options.baseUrl}${options.path}');
        return handler.next(options);
      },
      onResponse: (responce, handler) {
        print('Answer received: ${responce.data}');
        return handler.next(responce);
      },
    ),
  );
}
