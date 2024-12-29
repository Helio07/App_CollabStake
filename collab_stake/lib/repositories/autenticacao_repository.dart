import 'package:collab_stake/utils/custom_dio.dart';
import 'package:dio/dio.dart';

enum ErroAoLogar {credenciaisInvalidas}
class AutenticacaoRepository {
  final Dio _dio = CustomDio().dioInstance;

  Future<dynamic> login({required String email, required String senha}) async {
    try {
      final response = await _dio.post('auth/login',
          data: {"email": email, "password": senha});
          print("fez a requisição");
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print('entrou em catch e respota 401');
        return ErroAoLogar.credenciaisInvalidas;
      }
      rethrow;
    }
  }
}
