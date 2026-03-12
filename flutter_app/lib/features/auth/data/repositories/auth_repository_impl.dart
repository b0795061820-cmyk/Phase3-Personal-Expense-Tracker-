import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

import '../../../../core/utils/token_storage.dart';
import '../../../../injection_container.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  final tokenStorage = sl<TokenStorage>();

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {

    final tokenModel = await remoteDataSource.login(
      LoginRequestModel(
        email: email,
        password: password,
      ),
    );

    await tokenStorage.saveToken(tokenModel.accessToken);

    return tokenModel.accessToken;

  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {

    await remoteDataSource.register(
      RegisterRequestModel(
        name: name,
        email: email,
        password: password,
      ),
    );

    return UserEntity(
      id: 0,
      name: name,
      email: email,
      role: "user",
    );

  }

}