import 'package:collab_stake/utils/custom_dio.dart';
import 'package:dio/dio.dart';

enum ErroAoLogar { credenciaisInvalidas }

enum ErroAoCadastrar { emailExistente, senhaInvalida }

enum ErroAoTrocarSenha { senhaAtualIncorreta }

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

  Future<dynamic> cadastrar(
      {required String name,
      required String email,
      required String senha}) async {
    try {
      final response = await _dio.post('/auth/register',
          data: {"name": name, "email": email, "password": senha});
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return ErroAoCadastrar.emailExistente;
      } else if (e.response?.statusCode == 422) {
        print('entrou em catch e respota 402');
        return ErroAoCadastrar.senhaInvalida;
      }
      rethrow;
    }
  }

  Future<dynamic> atualiza(
      {String? name, String? email, String? telefone}) async {
    try {
      final response = await _dio.put('/user',
          data: {"name": name, "email": email, "telefone": telefone});
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return ErroAoCadastrar.emailExistente;
      } else if (e.response?.statusCode == 422) {
        print('entrou em catch e respota 402');
        return ErroAoCadastrar.senhaInvalida;
      }
      rethrow;
    }
  }

  Future<dynamic> buscarDados() async {
    try {
      final response = await _dio.get('/user/dados');
      return response.data;
    } on DioException catch (e) {
      //tratar isso
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return ErroAoCadastrar.emailExistente;
      }
      rethrow;
    }
  }

  Future<dynamic> trocarSenha(
      {required String senhaAtual,
      required String novaSenha,
      required String novaSenhaConfirmation}) async {
    try {
      final response = await _dio.post('/user/trocar-senha', data: {
        "senha_atual": senhaAtual,
        "nova_senha": novaSenha,
        "nova_senha_confirmation": novaSenhaConfirmation
      });
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        print('entrou em catch e respota 400');
        return;
      } else if (e.response?.statusCode == 403) {
        print('entrou em catch e respota 403');
        return ErroAoTrocarSenha.senhaAtualIncorreta;
      }
      rethrow;
    }
  }
}
