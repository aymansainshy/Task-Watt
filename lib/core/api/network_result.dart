import 'package:dio/dio.dart';

class NetworkResult<T> {
  final T? data;
  final int? code;
  final DioException? error;

  NetworkResult({
    this.data,
    this.code,
    this.error,
  });
}

class NetworkResultSuccess<T> extends NetworkResult<T> {
  NetworkResultSuccess({
    required super.data,
    super.code = 1,
  });
}

class NetworkResultFailure<T> extends NetworkResult<T> {
  NetworkResultFailure({
    required super.error,
    super.code = 0,
  });
}
