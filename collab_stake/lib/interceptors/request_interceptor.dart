import 'package:collab_stake/services/local_storage_service.dart';
import 'package:collab_stake/services/token_service.dart';
import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  final String baseUrl = const String.fromEnvironment('BASE_URL');

  RequestInterceptor();
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'accept': 'application/json',
      'content-type': 'application/json',
    });
    options.baseUrl = baseUrl;
    final listOfPaths = <String>['auth/login', 'auth/register'];
    
    
    if (listOfPaths.contains(options.path.toString())) {
      return handler.next(options);
    }
    var token = await TokenService().getToken();
    if (token != null && token.isNotEmpty) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    } else {
      print('Token não encontrado!');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(err);
    // if(err.response?.statusCode == 401 && err.requestOptions.path != 'auth/login'){
    //   final prefs = LocalStorageService();
    //   prefs.clear();
    //   TokenService().clearToken();
    //   NavigatorService.navigatorKey.currentState?.context.read<AutenticacaoBloc>().add(SetouUsuarioNaoAutenticadoEvent());    
    //   NavigatorService.navigatorKey.currentState?.pushReplacementNamed('/login');
    // }
    handler.next(err);
  }
}
