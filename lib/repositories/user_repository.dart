
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/user.dart';
import 'package:structure_flutter/data/source/remote/user_remote_datasource.dart';

import '../data/entities/user.dart';

abstract class UserRepository {
  Future<List<UserGitEntity>> getUser(int page);
}

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<List<UserGitEntity>> getUser(int page) async {
    return _userRemoteDataSource.getUser(page);
  }
}
