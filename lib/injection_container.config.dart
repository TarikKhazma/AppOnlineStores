// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:online_store/features/products/data/datasources/product_local_datasource.dart'
    as _i299;
import 'package:online_store/features/products/data/datasources/product_remote_datasource.dart'
    as _i682;
import 'package:online_store/features/products/data/repositories/product_repository_impl.dart'
    as _i503;
import 'package:online_store/features/products/domain/repositories/product_repository.dart'
    as _i912;
import 'package:online_store/features/products/domain/usecases/add_product_usecase.dart'
    as _i446;
import 'package:online_store/features/products/domain/usecases/delete_product_usecase.dart'
    as _i1018;
import 'package:online_store/features/products/domain/usecases/get_products_usecase.dart'
    as _i509;
import 'package:online_store/features/products/presentation/cubit/product_cubit.dart'
    as _i851;
import 'package:online_store/injection_container.dart' as _i148;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i299.ProductLocalDataSource>(
      () => appModule.localDataSource,
    );
    gh.lazySingleton<_i682.ProductRemoteDataSource>(
      () => _i682.ProductRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i912.ProductRepository>(
      () => _i503.ProductRepositoryImpl(
        remoteDataSource: gh<_i682.ProductRemoteDataSource>(),
        localDataSource: gh<_i299.ProductLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i446.AddProductUseCase>(
      () => _i446.AddProductUseCase(gh<_i912.ProductRepository>()),
    );
    gh.lazySingleton<_i1018.DeleteProductUseCase>(
      () => _i1018.DeleteProductUseCase(gh<_i912.ProductRepository>()),
    );
    gh.lazySingleton<_i509.GetProductsUseCase>(
      () => _i509.GetProductsUseCase(gh<_i912.ProductRepository>()),
    );
    gh.factory<_i851.ProductCubit>(
      () => _i851.ProductCubit(
        getProductsUseCase: gh<_i509.GetProductsUseCase>(),
        addProductUseCase: gh<_i446.AddProductUseCase>(),
        deleteProductUseCase: gh<_i1018.DeleteProductUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i148.AppModule {}
