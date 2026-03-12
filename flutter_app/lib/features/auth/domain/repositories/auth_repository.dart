import '../entities/user_entity.dart';

abstract class AuthRepository {

  Future<String> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });

}