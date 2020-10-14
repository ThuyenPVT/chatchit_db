// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/core/common/constants/app_constant.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasource.dart';

import '../bloc/blocs/user_bloc.dart';
import '../buildconfig/build_config.dart';
import '../data/source/remote/service/dio_client.dart';
import '../repositories/user_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);

  // Eager singletons must be registered in the right order
  gh.singleton<BuildConfig>(BuildConfig());
  gh.singleton<DioClient>(DioClient(AppConstant.BASE_URL, Dio()));
  gh.singleton<UserRemoteDataSource>(UserRemoteDataSourceImpl(get<DioClient>()));
  gh.singleton<UserRepository>(UserRepositoryImpl(get<UserRemoteDataSource>()));
  gh.singleton<UserGitBloc>(UserGitBloc());
  return get;
}
