// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/common/constants/app_constant.dart';
import 'package:structure_flutter/core/common/helpers/random_helper.dart';
import 'package:structure_flutter/data/source/remote/account_remote_datasource.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasource.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/repositories/user_repository.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

import '../buildconfig/build_config.dart';
import '../data/source/remote/service/dio_client.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);

  // Eager singletons must be registered in the right order
  // gh.singleton<UserGitBloc>(UserGitBloc());
  // gh.singleton<UserRepository>(UserRepositoryImpl(get<UserRemoteDataSource>()));

  gh.singleton<BuildConfig>(BuildConfig());
  gh.singleton<DioClient>(DioClient(AppConstant.BASE_URL, Dio()));
  gh.singleton<UserRemoteDataSource>(UserRemoteDataSourceImpl());
  gh.singleton<AccountRemoteDataSource>(AccountRemoteDataSourceImpl());
  gh.singleton<UserRepository>(UserRepository());
  gh.singleton<AccountRepository>(AccountRepositoryImpl());
  gh.singleton<SnackBarWidget>(SnackBarWidget());
  gh.singleton<RandomHelper>(RandomHelper(Random()));
  gh.singleton(AuthenticationBloc(Uninitialized()));
  gh.factory<LoginBloc>(() => LoginBloc(LoginState.empty()));
  gh.factory<RegisterBloc>(() => RegisterBloc(RegisterState.empty()));
  return get;
}
