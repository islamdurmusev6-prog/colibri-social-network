import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../features/authentication/data/models/login_response.dart';
import '../../datasource/local_data_source.dart';
import '../../di/injection.dart';
import '../failure.dart';
import 'api_constants.dart';
import '../logger/app_logger.dart';
import '../../config/app_config.dart';

@injectable
class ApiHelper {
  final Dio? dio = getIt<Dio>();
  final LocalDataSource? localDataSource;
  
  ApiHelper(this.localDataSource) {
    dio!.options.baseUrl = AppConfig.apiBaseUrl;
    
    // ИСПРАВЛЕНИЕ: Удален LogInterceptor который логировал чувствительные данные
    final interceptor = InterceptorsWrapper(
      onError: (e, handler) {
        // ИСПРАВЛЕНИЕ: Не логируем полный ответ, только статус
        AppLogger.error('API Error: ${e.response?.statusCode}');
      },
      onResponse: (res, handler) async {
        AppLogger.logApiResponse(res.requestOptions.path, res.statusCode ?? 0);
        handler.next(res);
      },
      onRequest: (req, handler) async {
        // ИСПРАВЛЕНИЕ: Добавляем токен ТОЛЬКО в headers, не в query параметры
        final UserAuth? loginResponse = await localDataSource!.getUserAuth();
        if (loginResponse != null) {
          req.headers.addAll({"Authorization": "Bearer ${loginResponse.authToken}"});
        }
        AppLogger.logApiRequest(req.method, req.path);
        handler.next(req);
      },
    );
    
    dio!.interceptors.add(interceptor);
    
    // ИСПРАВЛЕНИЕ: Логирование отключено в production
    if (AppConfig.enableDebugLogging) {
      dio!.interceptors.add(
        LogInterceptor(
          request: true,
          responseBody: false, // НЕ логируем тело ответа
          requestBody: false, // НЕ логируем тело запроса
          error: true,
          requestHeader: false, // НЕ логируем headers с токенами
        ),
      );
    }
      );
  }

  Future<Either<Failure, Response>> post(
    String path,
    HashMap<String, dynamic> body, {
    dynamic headers,
  }) async =>
      await safeApiHelperRequest(
        () async {
          final Response _res = await dio!.post(
            path,
            data: FormData.fromMap(body),
            options: Options(headers: headers),
          );
          return _res;
        },
      );

  Future<Either<Failure, Response>> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async =>
      safeApiHelperRequest(
        () => dio!.get(
          path,
          options: Options(headers: headers),
          queryParameters: queryParameters,
        ),
      );

  Future<Either<Failure, Response>> put<T>(
    String path, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async =>
      safeApiHelperRequest(
        () => dio!.put(
          path,
          options: Options(headers: headers),
          data: body,
        ),
      );

  Future<Either<Failure, Response>> safeApiHelperRequest(
    Future<dynamic> Function() function,
  ) async {
    try {
      // stores what is returned from this function
      final Response response = await (function.call());
      print(response);
      // he never reaches this line so we need to handle before call
      if (response.data["code"] == 200 || response.data["status"] == 200)
        return Right(response);
      else if (response.data["code"] == 204)
        return left(NoDataFoundFailure(
            response.data["message"] ?? "Something went wrong"));
      return Left(
          ServerFailure(response.data["message"] ?? "Something went wrong"));
    } on DioError catch (e) {
      return Left(ServerFailure(_handleError(e)));
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";

    DioError dioError = error;
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        errorDescription =
            "Received invalid status code: ${dioError.response!.statusCode}";
        break;
      case DioErrorType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.other:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
    }

    return errorDescription;
  }
}
