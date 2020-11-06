import 'package:injectable/injectable.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/data/source/remote/friend_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';

abstract class FriendRepository {
  Future<void> sendFriendRequest({
    String currentID,
    String recipientID,
    String name,
    bool pending,
  });

  Future<List<Account>> getListFriendAccount();
}

@Singleton(as: FriendRepository)
class FriendRepositoryImpl extends FriendRepository {
  final _friendRemoteDataSource = getIt<FriendRemoteDataSource>();

  @override
  Future<void> sendFriendRequest(
      {String currentID, String recipientID, String name, bool pending}) {
    return _friendRemoteDataSource.sendFriendRequest(
        currentID: currentID,
        recipientID: recipientID,
        name: name,
        pending: pending);
  }

  @override
  Future<List<Account>> getListFriendAccount() {
    return _friendRemoteDataSource.getListFriendAccount();
  }
}
