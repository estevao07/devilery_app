import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:delivery_app/app/repositories/auth/auth_repository.dart';

part 'register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterController(this._authRepository)
      : super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));
      await _authRepository.register(name, email, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } on Exception catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
