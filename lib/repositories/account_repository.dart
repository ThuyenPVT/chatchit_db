import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/data/source/remote/account_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

abstract class AccountRepository {
  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  );

  Future<List<Account>> getUsersByName(String searchName);

  Future<List<Account>> getUsers(String searchName);
}

@Singleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  final _accountRemoteDataSource = getIt<AccountRemoteDataSource>();

  @override
  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  ) {
    return _accountRemoteDataSource.createUser(uid, name, email, imageURL);
  }

  @override
  Future<List<Account>> getUsers(String searchName) {
    return _accountRemoteDataSource.getUsersByName(searchName);
  }

  @override
  Future<List<Account>> getUsersByName(String searchName) {
    return _accountRemoteDataSource.getUsersByName(searchName);
  }
}
