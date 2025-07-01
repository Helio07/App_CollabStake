import 'package:collab_stake/utils/custom_dio.dart';
import 'package:dio/dio.dart';


class ProjetoRepository {
  final Dio _dio = CustomDio().dioInstance;

  Future<dynamic> listaProjeto() async {
    try {
      final response = await _dio
          .get('projeto');
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle specific error response
        print('Erro ao listar projetos: ${e.response?.data}');
        return e.response?.data;
      } else {
        // Handle other Dio errors
        print('Erro de rede ou outro erro: $e');
        return {'error': 'Erro de rede ou outro erro: $e'};
      }
    }
  }

  Future<dynamic> criarProjeto({
    required String nome,
    required String endereco,
    required String areaAtuacao,
    required String descricao,
    required String dataInicio,
    required String dataFinal,
  }) async {
    try {
      final response = await _dio.post(
        'projeto',
        data: {
          'nome': nome,
          'endereco': endereco,
          'area_atuacao': areaAtuacao,
          'descricao': descricao,
          'data_inicio': dataInicio,
          'data_final': dataFinal,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle specific error response
        print('Erro ao criar projeto: ${e.response?.data}');
        return e.response?.data;
      } else {
        // Handle other Dio errors
        print('Erro de rede ou outro erro: $e');
        return {'error': 'Erro de rede ou outro erro: $e'};
      }
    }
  }

  Future<dynamic> favoritaProjeto({
    required bool favorito,
  }) async {
    try {
      final response = await _dio.put(
        'projeto/update',
        data: {
          'favorito': favorito,
        },
      );
      print(response.toString());
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle specific error response
        print('Erro ao favoritar projeto: ${e.response?.data}');
        return e.response?.data;
      } else {
        // Handle other Dio errors
        print('Erro de rede ou outro erro: $e');
        return {'error': 'Erro de rede ou outro erro: $e'};
      }
    }
  }

}
