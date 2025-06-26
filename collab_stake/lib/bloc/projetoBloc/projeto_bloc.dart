import 'package:bloc/bloc.dart';
import 'package:collab_stake/repositories/projeto_repository.dart';
import 'package:meta/meta.dart';

part 'projeto_event.dart';
part 'projeto_state.dart';

class ProjetoBloc extends Bloc<ProjetoEvent, ProjetoState> {
  ProjetoBloc({required ProjetoRepository projetoRepository}) : _projetoRepository = projetoRepository, super(ProjetoInitial()) {
    on<ListouProjetosEvent>(_listarProjetos);
  }
  final ProjetoRepository _projetoRepository;

  void _listarProjetos(ListouProjetosEvent event, Emitter<ProjetoState> emit) async {
    try {
      final response = await _projetoRepository.listaProjeto();
      print(response.toString());
    } catch (e) {
      print("erro no login: $e");
    } finally {
      //emit(state.copyWith(buscando: false));
    }
  }
}
