import 'package:dio/dio.dart';
import 'package:task_watt/config/app_config.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;

  DioInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // String? accessToken = AppConfig.user?.accessToken;

    // options.headers['content-type'] = 'application/json';
    // options.headers['Accept'] = 'application/json';

    // if (accessToken != null) {
    //   String endpointRoute = options.path;
    //
    //   if (endpointRoute == ApiRoutes.logOut ||
    //       endpointRoute == ApiRoutes.getProduct ||
    //       endpointRoute == ApiRoutes.createProduct ||
    //       endpointRoute == ApiRoutes.getOrders ||
    //       endpointRoute == ApiRoutes.createOrder ||
    //       endpointRoute.contains("order-details")) {
    //     options.headers['Authorization'] = 'Bearer $accessToken';
    //   }
    //
    //   if (endpointRoute == ApiRoutes.createProduct) {
    //     options.headers['content-type'] = 'multipart/form-data';
    //   }

    return handler.next(options);
    // }

    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print("DioInterceptor Response : ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // print('DioInterceptor ERROR[${err.error}] => PATH: ${err.requestOptions.uri} => ${err.response?.data}');
    super.onError(err, handler);
  }
}
