import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

/// Provider pro Dio klienta s přednastavenou bází URL.
@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://restcountries.com/v3.1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
}
