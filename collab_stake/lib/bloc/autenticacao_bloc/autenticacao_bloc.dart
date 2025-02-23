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
    on<SolicitouLoginEvent>(_solicitarLogin);
    on<ClearErroCredenciaisEvent>(_clearErroCredenciais);
  }

  final AutenticacaoRepository _autenticacaoRepository;

  void _solicitarLogin(SolicitouLoginEvent event, Emitter<AutenticacaoState> emit) async {
    // Inicia o loading
    emit(state.copyWith(buscando: true, credenciaisIncorretas: false));
    try {
      final response = await _autenticacaoRepository.login(
          email: event.email, senha: event.senha);
      if (response == ErroAoLogar.credenciaisInvalidas) {
        emit(state.copyWith(credenciaisIncorretas: true));
      } else if (response['data'] != null) {
        final usuario = Usuario.fromJson(response['data']);
        emit(AutenticacaoState.authenticated(usuario));
      }
    } catch (e) {
      print("erro no login: $e");
    } finally {
      // Encerra o loading
      emit(state.copyWith(buscando: false));
    }
  }

  void _clearErroCredenciais(ClearErroCredenciaisEvent event, Emitter<AutenticacaoState> emit) {
    emit(state.copyWith(credenciaisIncorretas: false));
  }
}
