import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisansarthi/core/config/env_config.dart';
import 'package:kisansarthi/core/storage/storage_service.dart';
import 'dart:developer' as dev;

// Create a StateProvider for baseUrl to trigger Dio recreation
final baseUrlProvider = StateProvider<String>((ref) => EnvConfig.apiBaseUrl);

final dioProvider = Provider<Dio>((ref) {
  // Watch the baseUrlProvider - when it changes, this provider will be recreated
  final baseUrl = ref.watch(baseUrlProvider);
  final storage = ref.watch(storageServiceProvider);
  final globalTimeout = Duration(
    milliseconds: EnvConfig.requestTimeoutMs < 120000
        ? 120000
        : EnvConfig.requestTimeoutMs,
  );
  
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: globalTimeout,
      receiveTimeout: globalTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    logPrint: (object) => dev.log(object.toString(), name: 'DIO'),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      if (!EnvConfig.isConfigured) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: "Please connect to backend first",
            type: DioExceptionType.cancel,
          ),
        );
      }
      
      // Ensure we use the absolute latest from EnvConfig
      options.baseUrl = EnvConfig.apiBaseUrl;
      final token = await storage.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      } else {
        options.headers.remove("Authorization");
      }
      
      dev.log("FINAL REQUEST URL: ${options.uri}", name: 'DIO_URL');
      return handler.next(options);
    },
  ));

  return dio;
});
