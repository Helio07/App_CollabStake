import 'package:collab_stake/utils/custom_dio.dart';
import 'package:dio/dio.dart';


class ProjetoRepository {
  final Dio _dio = CustomDio().dioInstance;

  Future<dynamic> listaProjeto() async {
    try {
      final response = await _dio
          .get('projeto');
      print(response.toString());
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

}
