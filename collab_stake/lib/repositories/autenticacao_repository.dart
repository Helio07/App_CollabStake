import 'package:collab_stake/utils/custom_dio.dart';
import 'package:dio/dio.dart';

enum ErroAoLogar { credenciaisInvalidas }
enum ErroAoCadastrar { emailExistente, senhaInvalida }

class AutenticacaoRepository {
  final Dio _dio = CustomDio().dioInstance;

  Future<dynamic> login({required String email, required String senha}) async {
    try {
      final response = await _dio
          .post('auth/login', data: {"email": email, "password": senha});
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return ErroAoLogar.credenciaisInvalidas;
      }
      rethrow;
    }
  }

  Future<dynamic> cadastrar({required String name,required String email, required String senha}) async {
    try {
      final response = await _dio
          .post('/auth/register', data: {"name": name, "email": email, "password": senha});
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return ErroAoCadastrar.emailExistente;
      }else if (e.response?.statusCode == 422) {
        print('entrou em catch e respota 402');
        return ErroAoCadastrar.senhaInvalida;
      }
      rethrow;
    }
  }

  Future<dynamic> atualiza({String? name, String? email, String? telefone}) async {
    try {
      final response = await _dio
          .put('/user', data: {"name": name, "email": email, "telefone": telefone});
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return ErroAoCadastrar.emailExistente;
      }else if (e.response?.statusCode == 422) {
        print('entrou em catch e respota 402');
        return ErroAoCadastrar.senhaInvalida;
      }
      rethrow;
    }
  }

  Future<dynamic> buscarDados() async {
    try {
      final response = await _dio
          .get('/user/dados');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return ErroAoCadastrar.emailExistente;
      }else if (e.response?.statusCode == 422) {
        print('entrou em catch e respota 402');
        return ErroAoCadastrar.senhaInvalida;
      }
      rethrow;
    }
  }
}
