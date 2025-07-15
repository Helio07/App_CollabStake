import 'dart:convert';

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
        super(const AutenticacaoState.unauthenticated()) {
    on<SolicitouLoginEvent>(_solicitarLogin);
    on<CarregouUsuarioLogadoEvent>(_carregarUsuarioLogado);
    on<SolicitouCadastrarEvent>(_solicitarCadastro);
    on<ClearErroCredenciaisEvent>(_clearErroCredenciais);
    on<ClearErroCadastroEvent>(_clearErroCadastro);
    on<AtualizouDadosEvent>(_atualizarDados);
    on<BuscoudadosEvent>(_buscarDados);
    on<TrocouSenhaEvent>(_trocarSenha);
    on<SolicitouLogoutEvent>(_logout);
    on<SetouUsuarioNaoAutenticadoEvent>(_setarUsuarioNaoAutenticado);
  }

  final AutenticacaoRepository _autenticacaoRepository;

  void _solicitarLogin(
      SolicitouLoginEvent event, Emitter<AutenticacaoState> emit) async {
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

  void _carregarUsuarioLogado(
      CarregouUsuarioLogadoEvent event, Emitter<AutenticacaoState> emit) async {
    try {
      final prefs = LocalStorageService();
      var usuario = await prefs.getString('usuario');
      Usuario usuarioFormatado = Usuario.fromJson(jsonDecode(usuario!));
      emit(AutenticacaoState.authenticated(usuarioFormatado));
      TokenService().setToken(usuarioFormatado.token);
      //add( BuscouDadosAtualizadosUsuario(withLoadingManager: false));

    } catch (e) {
      print("Erro ao carregar usuário logado: $e");
    }
  }

  void _solicitarCadastro(
      SolicitouCadastrarEvent event, Emitter<AutenticacaoState> emit) async {
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

  void _clearErroCredenciais(
      ClearErroCredenciaisEvent event, Emitter<AutenticacaoState> emit) {
    emit(state.copyWith(credenciaisIncorretas: false));
  }

  void _clearErroCadastro(
      ClearErroCadastroEvent event, Emitter<AutenticacaoState> emit) {
    emit(state.copyWith(emailExistente: false, senhaInvalida: false));
  }

  void _atualizarDados(
      AtualizouDadosEvent event, Emitter<AutenticacaoState> emit) async {
    emit(state.copyWith(buscando: true));
    try {
      final response = await _autenticacaoRepository.atualiza(
        name: event.name,
        email: event.email,
        telefone: event.telefone,
      );
      if (response != null) {
        add(BuscoudadosEvent());
      }
    } catch (e) {
      print("erro ao atualizar dados: $e");
    } finally {
      emit(state.copyWith(buscando: false));
    }
  }

  void _buscarDados(
      BuscoudadosEvent event, Emitter<AutenticacaoState> emit) async {
    emit(state.copyWith(buscando: true, credenciaisIncorretas: false));
    try {
      final response = await _autenticacaoRepository.buscarDados();
      if (response != null) {
        final dados = DadosUsuario.fromJson(response);
        final usuario = Usuario(
          token: state.usuario?.token,
          data: dados,
        );
        emit(state.copyWith(usuario: usuario));
        final prefs = LocalStorageService();
        await prefs.setString('usuario', usuario.toJson());
      }
    } catch (e) {
      print("erro ao buscar dados: $e");
    } finally {
      emit(state.copyWith(buscando: false));
    }
  }

  void _trocarSenha(
      TrocouSenhaEvent event, Emitter<AutenticacaoState> emit) async {
    emit(state.copyWith(buscando: true, senhaInvalida: false));
    try {
      final response = await _autenticacaoRepository.trocarSenha(
        senhaAtual: event.senhaAtual,
        novaSenha: event.novaSenha,
        novaSenhaConfirmation: event.novaSenhaConfirmation,
      );
      if (response == ErroAoTrocarSenha.senhaAtualIncorreta) {
        emit(state.copyWith(senhaInvalida: true));
      }
    } catch (e) {
      print("erro ao trocar senha: $e");
    } finally {
      emit(state.copyWith(buscando: false));
    }
  }

  void _logout(
      SolicitouLogoutEvent event, Emitter<AutenticacaoState> emit) async {
    try {
      print("tentando fazer logout");
      print(state.status);
      final response = await _autenticacaoRepository.logout();
      print("resposta da troca de senha: $response");
      print(state.status);
    } catch (e) {
      print("erro ao deslogar: $e");
    } finally {
      await TokenService().clearToken();
      await LocalStorageService().clear();
      emit(const AutenticacaoState.unauthenticated());
    }
  }

  void _setarUsuarioNaoAutenticado(SetouUsuarioNaoAutenticadoEvent event,
  Emitter<AutenticacaoState> emit) async {
    try{
      emit(const AutenticacaoState.unauthenticated());
    }catch (e){
      print("Erro ao setar usuário não autenticado: $e");
    }
    }
}
