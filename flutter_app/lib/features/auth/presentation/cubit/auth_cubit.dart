import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {

    emit(AuthLoading());

    try {

      await loginUseCase(
        email: email,
        password: password,
      );

      emit(AuthSuccess());

    } catch (e) {

      emit(AuthError(e.toString()));

    }

  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {

    emit(AuthLoading());

    try {

      await registerUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess());

    } catch (e) {

      emit(AuthError(e.toString()));

    }

  }

}