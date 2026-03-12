import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'core/utils/token_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton<DioClient>(
        () => DioClient(),
  );

  sl.registerLazySingleton<TokenStorage>(
        () => TokenStorage(),
  );

}