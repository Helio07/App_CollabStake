import 'package:bloc/bloc.dart';
import 'package:collab_stake/models/usuario.dart';
import 'package:collab_stake/repositories/autenticacao_repository.dart';
import 'package:collab_stake/services/local_storage_service.dart';
import 'package:collab_stake/services/token_service.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'autenticacao_event.dart';
part 'autenticacao_state.dart';

class AutenticacaoBloc extends Bloc<AutenticacaoEvent, AutenticacaoState> {
  AutenticacaoBloc({required AutenticacaoRepository autenticacaoRepository})
      : _autenticacaoRepository = autenticacaoRepository,
        super(AutenticacaoState.unauthenticated()) {
    on<SolicitouLoginEvent>(_solicitarLogin);
    on<SolicitouCadastrarEvent>(_solicitarCadastro);
    on<ClearErroCredenciaisEvent>(_clearErroCredenciais);
    on<ClearErroCadastroEvent>(_clearErroCadastro);
  }

  final AutenticacaoRepository _autenticacaoRepository;

  void _solicitarLogin(SolicitouLoginEvent event, Emitter<AutenticacaoState> emit) async {
    emit(state.copyWith(buscando: true, credenciaisIncorretas: false));
    try {
      final response = await _autenticacaoRepository.login(
          email: event.email, senha: event.senha);
      if (response == ErroAoLogar.credenciaisInvalidas) {
        emit(state.copyWith(credenciaisIncorretas: true));
      } else if (response['data'] != null) {
        final usuario = Usuario.fromJson(response);
        final prefs = LocalStorageService();
        await prefs.setString('usuario', usuario.toJson());
        emit(AutenticacaoState.authenticated(usuario));
        TokenService().setToken(usuario.token);
      }
    } catch (e) {
      print("erro no login: $e");
    } finally {
      emit(state.copyWith(buscando: false));
    }
  }

  void _solicitarCadastro(SolicitouCadastrarEvent event, Emitter<AutenticacaoState> emit) async {
    emit(state.copyWith(buscando: true));
    try {
      final response = await _autenticacaoRepository.cadastrar(
          name: event.name, email: event.email, senha: event.senha);
      if (response == ErroAoCadastrar.emailExistente) {
        emit(state.copyWith(emailExistente: true));
      } else if (response == ErroAoCadastrar.senhaInvalida) {
        emit(state.copyWith(senhaInvalida: true));
      } else if (response['data'] != null) {
        emit(state.copyWith(cadastroRealizado: true));
      }
    } catch (e) {
      print("erro no cadastro: $e");
    } finally {
      emit(state.copyWith(buscando: false));
    }
  }

  void _clearErroCredenciais(ClearErroCredenciaisEvent event, Emitter<AutenticacaoState> emit) {
    emit(state.copyWith(credenciaisIncorretas: false));
  }

  void _clearErroCadastro(ClearErroCadastroEvent event, Emitter<AutenticacaoState> emit) {
    emit(state.copyWith(emailExistente: false, senhaInvalida: false));
  }
}
