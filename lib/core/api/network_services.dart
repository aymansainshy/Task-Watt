import 'package:task_watt/core/api/network_result.dart';

abstract class NetworkServices<T> {
  Future<NetworkResult<T>> get(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<NetworkResult<T>> post(String url, {Object? data});

  Future<NetworkResult<T>> patch(String url, {Map<String, dynamic>? data});

  Future<NetworkResult<T>> put(String url, {Map<String, dynamic>? data});

  Future<NetworkResult<T>> delete(String url, {Map<String, dynamic>? data});
}
