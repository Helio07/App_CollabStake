import 'package:bloc/bloc.dart';
import 'package:collab_stake/models/usuario.dart';
import 'package:collab_stake/repositories/autenticacao_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'autenticacao_event.dart';
part 'autenticacao_state.dart';

class AutenticacaoBloc extends Bloc<AutenticacaoEvent, AutenticacaoState> {
  AutenticacaoBloc({required AutenticacaoRepository autenticacaoRepository})
      : _autenticacaoRepository = autenticacaoRepository,
        super(AutenticacaoState.unauthenticated()) {
    on<AutenticacaoEvent>((event, emit) {});
    on<SolicitouLoginEvent>(_solicitarLogin);
  }

  final AutenticacaoRepository _autenticacaoRepository;

  void _solicitarLogin(
      SolicitouLoginEvent event, Emitter<AutenticacaoState> emit) async {
    try {
      emit(state.copyWith(credenciaisIncorretas: false));
      print("chamando a rota");
      var response = await _autenticacaoRepository.login(
          email: event.email, senha: event.senha);
          print(response);
    } catch (e) {
      print("erro no login: $e");
    }
  }
}
