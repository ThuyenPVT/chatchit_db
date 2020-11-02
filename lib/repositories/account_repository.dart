import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/data/source/remote/account_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

class AccountRepository {
  final _accountRemoteDataSource = getIt<AccountRemoteDataSource>();

  Future<void> createUser(
    String uid,
    String name,
    String email,
    String imageURL,
  ) {
    return _accountRemoteDataSource.createUser(uid, name, email, imageURL);
  }

  Future<List<Account>> getUsers(String searchName) {
    return _accountRemoteDataSource.getUsers(searchName);
  }
}
