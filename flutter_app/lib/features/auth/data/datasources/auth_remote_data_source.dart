import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../injection_container.dart';

import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/token_model.dart';

class AuthRemoteDataSource {

  final Dio dio = sl<DioClient>().dio;

  Future<TokenModel> login(LoginRequestModel model) async {

    final response = await dio.post(
      ApiConstants.login,
      data: model.toJson(),
    );

    return TokenModel.fromJson(response.data);

  }

  Future<void> register(RegisterRequestModel model) async {

    await dio.post(
      ApiConstants.register,
      data: model.toJson(),
    );

  }

}