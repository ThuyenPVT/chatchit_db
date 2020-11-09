// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// ************************************************************************
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/bloc/blocs/friend_bloc.dart';
import 'package:structure_flutter/core/common/constants/app_constant.dart';
import 'package:structure_flutter/core/common/helpers/random_helper.dart';
import 'package:structure_flutter/core/utils/date_time_utils.dart';
import 'package:structure_flutter/core/utils/media_utils.dart';
import 'package:structure_flutter/data/source/remote/account_remote_datasource.dart';
import 'package:structure_flutter/data/source/remote/conversation_remote_datasource.dart';
import 'package:structure_flutter/data/source/remote/friend_remote_datasource.dart';
import 'package:structure_flutter/data/source/remote/storage_remote_datasource.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasource.dart';
import 'package:structure_flutter/repositories/account_repository.dart';
import 'package:structure_flutter/repositories/conversation_repository.dart';
import 'package:structure_flutter/repositories/friend_repository.dart';
import 'package:structure_flutter/repositories/storage_repository.dart';
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

  gh.singleton<BuildConfig>(BuildConfig());
  gh.singleton<DioClient>(DioClient(AppConstant.BASE_URL, Dio()));
  //DataSource
  gh.singleton<UserRemoteDataSource>(
      UserRemoteDataSourceImpl(FirebaseAuth.instance, GoogleSignIn()));
  gh.singleton<AccountRemoteDataSource>(AccountRemoteDataSourceImpl());
  gh.singleton<StorageRemoteDataSource>(StorageRemoteDataSourceImpl(
    FirebaseStorage.instance.ref(),
  ));
  gh.singleton<FriendRemoteDataSource>(FriendRemoteDataSourceImpl());
  gh.singleton<ConversationRemoteDataSource>(
    ConversationRemoteDataSourceImpl(),
  );
  //Repository
  gh.singleton<UserRepository>(UserRepository());
  gh.singleton<StorageRepository>(StorageRepository());
  gh.singleton<FriendRepository>(FriendRepositoryImpl());
  gh.singleton<AccountRepository>(AccountRepositoryImpl());
  gh.singleton<ConversationRepository>(ConversationRepositoryImpl());

  //Utils
  gh.singleton<MediaUtil>(MediaUtil());
  gh.singleton<DateTimeUtils>(DateTimeUtils());

  //Widget
  gh.singleton<RandomHelper>(RandomHelper(Random()));
  gh.singleton<SnackBarWidget>(SnackBarWidget());

  //Bloc
  gh.singleton(AuthenticationBloc(Uninitialized()));
  gh.singleton(FriendBloc(LoadingData()));
  gh.singleton(ConversationBloc(InitialConversation()));

  gh.factory<LoginBloc>(() => LoginBloc(LoginState.empty()));
  gh.factory<RegisterBloc>(() => RegisterBloc(RegisterState.empty()));
  return get;
}
