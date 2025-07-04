import 'package:bloc/bloc.dart';
import 'package:collab_stake/models/projeto.dart';
import 'package:collab_stake/repositories/projeto_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'projeto_event.dart';
part 'projeto_state.dart';

class ProjetoBloc extends Bloc<ProjetoEvent, ProjetoState> {
  ProjetoBloc({required ProjetoRepository projetoRepository}) : _projetoRepository = projetoRepository, super(const ProjetoState()) {
    on<ListouProjetosEvent>(_listarProjetos);
    on<CriouProjetosEvent>(criarProjeto); 
    on<FavoritouProjetosEvent>(favoritaProjeto);
  }
  final ProjetoRepository _projetoRepository;

  void _listarProjetos(ListouProjetosEvent event, Emitter<ProjetoState> emit) async {
    try {
      final response = await _projetoRepository.listaProjeto();
      if (response.isNotEmpty) {
        final projetos = Projeto.fromJsonList(response);
        emit(state.copyWith(projetos: projetos));
      } else {
        emit(state.copyWith(projetos: []));
      }
    } catch (e) {
      print("erro no login: $e");
    } finally {
      //emit(state.copyWith(buscando: false));
    }
  }

  void criarProjeto(CriouProjetosEvent event, Emitter<ProjetoState> emit) async {
    try {
      await _projetoRepository.criarProjeto(
        nome: event.nome,
        endereco: event.endereco,
        areaAtuacao: event.areaAtuacao,
        descricao: event.descricao,
        dataInicio: event.dataInicio,
        dataFinal: event.dataFinal,
      );
      add(const ListouProjetosEvent());
    } catch (e) {
      print("erro ao criar projeto: $e");
    } finally {
      //emit(state.copyWith(buscando: false));
    }
  }

  void favoritaProjeto(FavoritouProjetosEvent event, Emitter<ProjetoState> emit) async {
    try {
      await _projetoRepository.favoritaProjeto(
        idProjeto: event.idProjeto,
        favorito: event.favorito,
      );
      add(const ListouProjetosEvent());
    } catch (e) {
      print("erro ao criar projeto: $e");
    } finally {
      //emit(state.copyWith(buscando: false));
    }
  }
}