import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/network/dio_client.dart';
import 'features/products/data/datasources/product_local_datasource.dart';
import 'features/products/data/datasources/product_local_datasource_web.dart';
import 'injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit()
void setupDependencies() => sl.init();

@module
abstract class AppModule {
  // Provides the configured Dio instance
  @lazySingleton
  Dio get dio => DioClient().dio;

  // Picks SQLite on native, SharedPreferences on web
  @lazySingleton
  ProductLocalDataSource get localDataSource =>
      kIsWeb ? ProductLocalDataSourceWeb() : ProductLocalDataSourceImpl();
}
